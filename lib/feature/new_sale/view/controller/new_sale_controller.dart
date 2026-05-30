import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../core/utils/logger.dart';
import '../../../product/domain/product_model.dart';
import '../../data/services/new_sale_service.dart';
import '../../domain/new_sale_model.dart';
import '../state/new_sale_state.dart';

final newSaleControllerProvider =
    StateNotifierProvider.autoDispose<NewSaleController, NewSaleState>(
  (ref) => NewSaleController(ref.watch(newSaleServiceProvider)),
);

class NewSaleController extends StateNotifier<NewSaleState> {
  NewSaleController(this._service) : super(const NewSaleState.initial()) {
    load();
  }

  final NewSaleService _service;

  // Helper: returns ready state or null — avoids referencing private _Ready class
  dynamic get _s => state.mapOrNull(ready: (s) => s);

  Future<void> load() async {
    state = const NewSaleState.loading();
    try {
      final products = await _service.getProducts();
      final branches = await _service.getBranches();
      state = NewSaleState.ready(
        products:
            products.where((p) => p.state && p.stockQuantity > 0).toList(),
        branches: branches,
        cart: const [],
        selectedBranch: branches.isNotEmpty ? branches.first : null,
      );
    } catch (e) {
      state = NewSaleState.error(parseError(e));
    }
  }

  void addToCart(ProductModel product, int quantity) {
    final s = _s;
    if (s == null) return;
    // Precio según si el cliente tiene poma o no (se puede cambiar en el paso 2)
    final hasContainer = s.hasContainer as bool;
    final price = product.priceFor(hasContainer);
    final existing =
        (s.cart as List<CartItem>).indexWhere((c) => c.productId == product.id);
    List<CartItem> newCart;
    if (existing >= 0) {
      newCart = [...s.cart as List<CartItem>];
      newCart[existing] =
          newCart[existing].copyWith(quantity: newCart[existing].quantity + quantity);
    } else {
      newCart = [
        ...s.cart as List<CartItem>,
        CartItem(
          productId: product.id,
          productName: product.name,
          unitPrice: price,
          quantity: quantity,
          productType: product.productType?.name ?? '',
        ),
      ];
    }
    state = (s as dynamic).copyWith(cart: newCart) as NewSaleState;
  }

  void removeFromCart(int productId) {
    final s = _s;
    if (s == null) return;
    final newCart = (s.cart as List<CartItem>)
        .where((c) => c.productId != productId)
        .toList();
    state = (s as dynamic).copyWith(cart: newCart) as NewSaleState;
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    final s = _s;
    if (s == null) return;
    final newCart = (s.cart as List<CartItem>)
        .map((c) => c.productId == productId ? c.copyWith(quantity: quantity) : c)
        .toList();
    state = (s as dynamic).copyWith(cart: newCart) as NewSaleState;
  }

  void selectBranch(BranchModel branch) {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(selectedBranch: branch) as NewSaleState;
  }

  void setPaymentMethod(String method) {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(paymentMethod: method) as NewSaleState;
  }

  void setClientName(String v) {
    final s = _s;
    if (s != null) state = (s as dynamic).copyWith(clientName: v) as NewSaleState;
  }

  void setClientPhone(String v) {
    final s = _s;
    if (s != null) state = (s as dynamic).copyWith(clientPhone: v) as NewSaleState;
  }

  void setClientEmail(String v) {
    final s = _s;
    if (s != null) state = (s as dynamic).copyWith(clientEmail: v) as NewSaleState;
  }

  void setObservation(String v) {
    final s = _s;
    if (s != null) state = (s as dynamic).copyWith(observation: v) as NewSaleState;
  }

  void setHasContainer(bool v) {
    final s = _s;
    if (s == null) return;
    // Recalcular precios del carrito con el nuevo tipo de poma
    final products = s.products as List<ProductModel>;
    final updatedCart = (s.cart as List<CartItem>).map((item) {
      final product = products.firstWhere(
        (p) => p.id == item.productId,
        orElse: () => ProductModel(id: item.productId),
      );
      final newPrice = product.priceFor(v);
      return item.copyWith(unitPrice: newPrice);
    }).toList();
    state = (s as dynamic).copyWith(hasContainer: v, cart: updatedCart) as NewSaleState;
  }

  double get total {
    final s = _s;
    if (s == null) return 0;
    return (s.cart as List<CartItem>).fold(0.0, (sum, c) => sum + c.subtotal);
  }

  Future<bool> submitSale() async {
    final s = _s;
    if (s == null) return false;
    final cart = s.cart as List<CartItem>;
    final branch = s.selectedBranch as BranchModel?;
    final clientName = (s.clientName as String).trim();

    // Validaciones previas — devuelven error legible en vez de fallar silencioso.
    if (cart.isEmpty) {
      state = (s as dynamic).copyWith(submitError: 'El carrito está vacío.') as NewSaleState;
      return false;
    }
    if (branch == null) {
      state = (s as dynamic).copyWith(submitError: 'Selecciona una sucursal.') as NewSaleState;
      return false;
    }
    if (clientName.isEmpty) {
      state = (s as dynamic)
          .copyWith(submitError: 'Ingresa el nombre del cliente.') as NewSaleState;
      return false;
    }

    state = (s as dynamic).copyWith(submitting: true, submitError: null) as NewSaleState;
    try {
      final request = NewSaleRequest(
        branchId: branch.id,
        paymentMethod: s.paymentMethod as String,
        observation: s.observation as String,
        client: NewSaleClient(
          name: clientName,
          phone: s.clientPhone as String,
          email: s.clientEmail as String,
          hasContainer: s.hasContainer as bool,
        ),
        items: cart
            .map((c) => NewSaleItem(productId: c.productId, quantity: c.quantity))
            .toList(),
      );
      await _service.createSale(request);
      state = (s as dynamic).copyWith(
        submitting: false,
        success: true,
        submitError: null,
        cart: <CartItem>[],
      ) as NewSaleState;
      return true;
    } on DioException catch (e) {
      ErrorLogger(runtimeType).dio(e, 'submitSale');
      final msg = _extractDioError(e);
      state = (s as dynamic).copyWith(submitting: false, submitError: msg) as NewSaleState;
      return false;
    } catch (e) {
      ErrorLogger(runtimeType).regular(e, 'submitSale');
      state = (s as dynamic)
          .copyWith(submitting: false, submitError: 'Ocurrió un error: $e') as NewSaleState;
      return false;
    }
  }

  /// Extrae un mensaje legible del DioException (ej: errores de validación DRF).
  String _extractDioError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final parts = <String>[];
      data.forEach((key, value) {
        if (value is List) {
          parts.add('$key: ${value.join(", ")}');
        } else {
          parts.add('$key: $value');
        }
      });
      if (parts.isNotEmpty) return parts.join('\n');
    }
    if (data is String && data.isNotEmpty) return data;
    return e.message ?? 'Error al guardar la venta.';
  }

  void clearSubmitError() {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(submitError: null) as NewSaleState;
  }
}
