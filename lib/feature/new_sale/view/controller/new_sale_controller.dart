import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../core/utils/logger.dart';
import '../../../client/domain/client_model.dart';
import '../../../product/domain/product_model.dart';
import '../../data/services/new_sale_service.dart';
import '../../domain/new_sale_model.dart';
import '../state/new_sale_state.dart';

const _uuid = Uuid();

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
      final paymentMethods = await _service.getPaymentMethods();
      state = NewSaleState.ready(
        products:
            products.where((p) => p.state && p.stockQuantity > 0).toList(),
        paymentMethods: paymentMethods,
        cart: const [],
        standaloneContainers: const [],
        paymentMethod:
            paymentMethods.isNotEmpty ? paymentMethods.first.value : 'EFECTIVO',
      );
    } catch (e) {
      state = NewSaleState.error(parseError(e));
    }
  }

  // ── Cliente ──────────────────────────────────────────────────────
  void setClient(ClientModel client) {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(client: client) as NewSaleState;
  }

  void clearClient() {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(client: null) as NewSaleState;
  }

  /// Saldo de pomas que el sistema le reconoce al cliente seleccionado para
  /// un tipo de envase — 0 si no hay cliente o no tiene registradas.
  int clientBalanceFor(int containerTypeId) {
    final s = _s;
    if (s == null) return 0;
    final client = s.client as ClientModel?;
    return client?.balanceFor(containerTypeId) ?? 0;
  }

  // ── Carrito de productos ─────────────────────────────────────────
  void addToCart(
    ProductModel product, {
    required int quantity,
    int returnedContainerQuantity = 0,
  }) {
    final s = _s;
    if (s == null) return;
    final cart = List<CartItem>.from(s.cart as List<CartItem>);
    final existingIndex = cart.indexWhere((c) => c.productId == product.id);
    final item = CartItem(
      productId: product.id,
      productName: product.name,
      unitPrice: product.activePrice ?? '0.00',
      quantity: quantity,
      productType: product.productType?.name ?? '',
      isReturnable: product.isReturnable,
      returnableContainer: product.returnableContainer,
      returnedContainerQuantity: returnedContainerQuantity,
    );
    if (existingIndex >= 0) {
      cart[existingIndex] = item;
    } else {
      cart.add(item);
    }
    state = (s as dynamic).copyWith(cart: cart) as NewSaleState;
  }

  void removeFromCart(int productId) {
    final s = _s;
    if (s == null) return;
    final newCart = (s.cart as List<CartItem>)
        .where((c) => c.productId != productId)
        .toList();
    state = (s as dynamic).copyWith(cart: newCart) as NewSaleState;
  }

  // ── Envases sueltos ("poma sola") ────────────────────────────────
  void addStandaloneContainer(ReturnableContainerModel container, int quantity) {
    final s = _s;
    if (s == null) return;
    final list = List<StandaloneContainerItem>.from(
        s.standaloneContainers as List<StandaloneContainerItem>);
    final existingIndex =
        list.indexWhere((c) => c.containerTypeId == container.id);
    final item = StandaloneContainerItem(
      containerTypeId: container.id,
      containerTypeName: container.name,
      unitPrice: container.price ?? '0.00',
      quantity: quantity,
    );
    if (existingIndex >= 0) {
      list[existingIndex] = item;
    } else {
      list.add(item);
    }
    state = (s as dynamic).copyWith(standaloneContainers: list) as NewSaleState;
  }

  void removeStandaloneContainer(int containerTypeId) {
    final s = _s;
    if (s == null) return;
    final list = (s.standaloneContainers as List<StandaloneContainerItem>)
        .where((c) => c.containerTypeId != containerTypeId)
        .toList();
    state = (s as dynamic).copyWith(standaloneContainers: list) as NewSaleState;
  }

  // ── Datos de la venta ────────────────────────────────────────────
  void setPaymentMethod(String method) {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(paymentMethod: method) as NewSaleState;
  }

  void setObservation(String v) {
    final s = _s;
    if (s != null) state = (s as dynamic).copyWith(observation: v) as NewSaleState;
  }

  // ── Totales ──────────────────────────────────────────────────────
  double get productsTotal {
    final s = _s;
    if (s == null) return 0;
    return (s.cart as List<CartItem>)
        .fold(0.0, (sum, c) => sum + c.productSubtotal);
  }

  double get newContainersTotal {
    final s = _s;
    if (s == null) return 0;
    final fromReturnable = (s.cart as List<CartItem>)
        .fold(0.0, (sum, c) => sum + c.containerSubtotal);
    final fromStandalone = (s.standaloneContainers as List<StandaloneContainerItem>)
        .fold(0.0, (sum, c) => sum + c.subtotal);
    return fromReturnable + fromStandalone;
  }

  double get total => productsTotal + newContainersTotal;

  bool get isEmpty {
    final s = _s;
    if (s == null) return true;
    return (s.cart as List<CartItem>).isEmpty &&
        (s.standaloneContainers as List<StandaloneContainerItem>).isEmpty;
  }

  // ── Envío ────────────────────────────────────────────────────────
  Future<bool> submitSale() async {
    final s = _s;
    if (s == null) return false;
    final client = s.client as ClientModel?;
    final cart = s.cart as List<CartItem>;
    final standalone = s.standaloneContainers as List<StandaloneContainerItem>;

    if (client == null) {
      state = (s as dynamic)
          .copyWith(submitError: 'Selecciona un cliente antes de confirmar.') as NewSaleState;
      return false;
    }
    if (cart.isEmpty && standalone.isEmpty) {
      state = (s as dynamic)
          .copyWith(submitError: 'Agrega al menos un producto o envase.') as NewSaleState;
      return false;
    }

    // El operation_id se genera UNA sola vez por venta — si el envío falla
    // y el empleado reintenta, se reusa el mismo para que el backend lo
    // reconozca como el mismo intento (evita duplicar la venta).
    final operationId = (s.operationId as String?) ?? _uuid.v4();

    state = (s as dynamic).copyWith(
      submitting: true,
      submitError: null,
      operationId: operationId,
    ) as NewSaleState;

    try {
      final request = NewSaleRequest(
        operationId: operationId,
        clientId: client.id,
        paymentMethod: s.paymentMethod as String,
        observation: s.observation as String,
        items: cart,
        standaloneContainers: standalone,
      );
      await _service.createSale(request);
      state = (s as dynamic).copyWith(
        submitting: false,
        success: true,
        submitError: null,
      ) as NewSaleState;
      return true;
    } on DioException catch (e) {
      ErrorLogger(runtimeType).dio(e, 'submitSale');
      state = (s as dynamic)
          .copyWith(submitting: false, submitError: parseError(e)) as NewSaleState;
      return false;
    } catch (e) {
      ErrorLogger(runtimeType).regular(e, 'submitSale');
      state = (s as dynamic)
          .copyWith(submitting: false, submitError: parseError(e)) as NewSaleState;
      return false;
    }
  }

  void clearSubmitError() {
    final s = _s;
    if (s == null) return;
    state = (s as dynamic).copyWith(submitError: null) as NewSaleState;
  }
}
