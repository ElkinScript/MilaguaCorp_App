// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/widget/mg_widgets.dart';
import '../../../auth/domain/user_model.dart';
import '../../../auth/view/controller/auth_controller.dart';
import '../../../client/domain/client_model.dart';
import '../../../client/view/widget/client_search_view.dart';
import '../../../product/domain/product_model.dart';
import '../../domain/new_sale_model.dart';
import '../controller/new_sale_controller.dart';
import '../state/new_sale_state.dart';

class NewSaleBottomSheet extends ConsumerStatefulWidget {
  const NewSaleBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ProviderScope(child: NewSaleBottomSheet()),
    );
  }

  @override
  ConsumerState<NewSaleBottomSheet> createState() =>
      _NewSaleBottomSheetState();
}

// 0=Productos, 1=Detalle (incluye cliente), 2=Confirmar.
// El cliente se busca/registra DENTRO de Detalle, no como paso obligatorio
// antes de ver productos — en la operación real, el empleado ya sabe qué
// está vendiendo antes de anotar los datos del cliente (eso pasa al cerrar
// la venta, no al abrirla).
const _kSteps = ['Productos', 'Detalle', 'Confirmar'];

class _NewSaleBottomSheetState extends ConsumerState<NewSaleBottomSheet> {
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newSaleControllerProvider);
    final ctrl = ref.read(newSaleControllerProvider.notifier);

    ref.listen<NewSaleState>(newSaleControllerProvider, (prev, next) {
      final err = next.mapOrNull(ready: (s) => s.submitError);
      if (err != null && err.isNotEmpty) {
        MgToast.error(context, err);
        ctrl.clearSubmitError();
      }
    });

    return MgBottomSheet(
      title: 'Nueva Venta',
      scrollable: false,
      showCloseButton: false,
      initialHeightFactor: 0.92,
      padding: EdgeInsets.zero,
      childBuilder: (context, scrollController) {
        return Column(
          children: [
            _StepIndicator(currentStep: _step),
            Expanded(
              child: state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (msg) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: AppColors.error),
                        const Gap(16),
                        Text(msg, textAlign: TextAlign.center),
                        const Gap(16),
                        MgBtn(label: 'Reintentar', onTap: () => ctrl.load()),
                      ],
                    ),
                  ),
                ),
                ready: (products, paymentMethods, client, cart,
                    standaloneContainers, paymentMethod, observation,
                    operationId, submitting, success, submitError) {
                  switch (_step) {
                    case 0:
                      return _ProductsStep(
                        products: products,
                        cart: cart,
                        standaloneContainers: standaloneContainers,
                        scrollController: scrollController,
                        ctrl: ctrl,
                        onNext: () => setState(() => _step = 1),
                      );
                    case 1:
                      return _DetailStep(
                        client: client,
                        cart: cart,
                        standaloneContainers: standaloneContainers,
                        paymentMethods: paymentMethods,
                        paymentMethod: paymentMethod,
                        observation: observation,
                        scrollController: scrollController,
                        ctrl: ctrl,
                        total: ctrl.total,
                        onBack: () => setState(() => _step = 0),
                        onNext: () => setState(() => _step = 2),
                      );
                    default:
                      final matchingMethods = paymentMethods
                          .where((m) => m.value == paymentMethod)
                          .toList();
                      return _ConfirmStep(
                        client: client,
                        cart: cart,
                        standaloneContainers: standaloneContainers,
                        productsTotal: ctrl.productsTotal,
                        newContainersTotal: ctrl.newContainersTotal,
                        total: ctrl.total,
                        paymentMethod: matchingMethods.isNotEmpty
                            ? matchingMethods.first.label
                            : paymentMethod,
                        submitting: submitting,
                        onBack: () => setState(() => _step = 2),
                        onConfirm: () async {
                          final ok = await ctrl.submitSale();
                          if (ok && context.mounted) {
                            MgToast.success(
                                context, 'Venta registrada correctamente');
                            Navigator.pop(context, true);
                          }
                        },
                      );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Step indicator
// ════════════════════════════════════════════════════════════════════

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(_kSteps.length, (i) {
          final active = i <= currentStep;
          return Expanded(
            child: Row(
              children: [
                if (i > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: active
                          ? AppColors.primary
                          : colorScheme.outlineVariant,
                    ),
                  ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primary
                        : colorScheme.outlineVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: active
                            ? Colors.white
                            : colorScheme.onSurfaceVariant,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (i < _kSteps.length - 1) const Expanded(child: SizedBox()),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Step 1: Productos (+ envases sueltos)
// ════════════════════════════════════════════════════════════════════

class _ProductsStep extends StatelessWidget {
  const _ProductsStep({
    required this.products,
    required this.cart,
    required this.standaloneContainers,
    required this.scrollController,
    required this.ctrl,
    required this.onNext,
  });

  final List<ProductModel> products;
  final List<CartItem> cart;
  final List<StandaloneContainerItem> standaloneContainers;
  final ScrollController scrollController;
  final NewSaleController ctrl;
  final VoidCallback onNext;

  List<ReturnableContainerModel> get _containerTypes {
    final map = <int, ReturnableContainerModel>{};
    for (final p in products) {
      final c = p.returnableContainer;
      if (c != null) map[c.id] = c;
    }
    return map.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final itemCount = cart.length + standaloneContainers.length;
    final total = ctrl.total;

    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              const _SectionTitle('Productos'),
              const Gap(8),
              ...products.map((p) {
                final inCart = cart.any((c) => c.productId == p.id);
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        p.isReturnable
                            ? Icons.water_drop
                            : Icons.inventory_2_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(p.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Text(
                      p.isReturnable
                          ? 'Retornable · ${p.returnableContainer?.name ?? ''}'
                          : p.productType?.name ?? '',
                      style: TextStyle(
                          fontSize: 12, color: colorScheme.onSurfaceVariant),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$${p.activePrice ?? "—"}',
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            Text('Stock: ${p.stockQuantity}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: colorScheme.onSurfaceVariant)),
                          ],
                        ),
                        const Gap(8),
                        IconButton(
                          icon: Icon(
                            inCart ? Icons.check_circle : Icons.add_circle_outline,
                            color: inCart
                                ? const Color(0xFF22c55e)
                                : AppColors.primary,
                          ),
                          onPressed: () => _openProductDialog(context, p),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              if (_containerTypes.isNotEmpty) ...[
                const Gap(16),
                const _SectionTitle('Envases / Pomas'),
                const Gap(4),
                Text(
                  'Vender un envase vacío solo, sin agua.',
                  style: TextStyle(
                      fontSize: 12, color: colorScheme.onSurfaceVariant),
                ),
                const Gap(8),
                ..._containerTypes.map((c) {
                  final inCart =
                      standaloneContainers.any((s) => s.containerTypeId == c.id);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.warningLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.liquor_outlined,
                            color: AppColors.warning, size: 20),
                      ),
                      title: Text(c.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: Text('Envase solo',
                          style: TextStyle(
                              fontSize: 12, color: colorScheme.onSurfaceVariant)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('\$${c.price ?? "—"}',
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                          const Gap(8),
                          IconButton(
                            icon: Icon(
                              inCart
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                              color: inCart
                                  ? const Color(0xFF22c55e)
                                  : AppColors.primary,
                            ),
                            onPressed: () =>
                                _openStandaloneDialog(context, c),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
          ),
          child: MgBtn(
            label: itemCount > 0
                ? 'Continuar ($itemCount) — \$${total.toStringAsFixed(2)}'
                : 'Agrega al menos un producto',
            onTap: itemCount > 0 ? onNext : null,
          ),
        ),
      ],
    );
  }

  void _openProductDialog(BuildContext context, ProductModel product) {
    if (product.isReturnable) {
      showReturnableProductDialog(context, product: product, ctrl: ctrl);
    } else {
      showSimpleQuantityDialog(
        context,
        title: product.name,
        price: product.activePrice,
        maxQuantity: product.stockQuantity,
        onConfirm: (qty) => ctrl.addToCart(product, quantity: qty),
      );
    }
  }

  void _openStandaloneDialog(BuildContext context, ReturnableContainerModel c) {
    showSimpleQuantityDialog(
      context,
      title: c.name,
      price: c.price,
      maxQuantity: 999,
      onConfirm: (qty) => ctrl.addStandaloneContainer(c, qty),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Modal: producto retornable — cantidad + pomas recibidas + nuevas calculadas
// (doc Empleado V1, sección 42)
// ════════════════════════════════════════════════════════════════════

void showReturnableProductDialog(
  BuildContext context, {
  required ProductModel product,
  required NewSaleController ctrl,
  CartItem? existing,
}) {
  final container = product.returnableContainer;
  final clientBalance =
      container != null ? ctrl.clientBalanceFor(container.id) : 0;
  int quantity = existing?.quantity ?? 1;
  int returned = existing?.returnedContainerQuantity ?? 0;
  if (returned > quantity) returned = quantity;
  if (returned > clientBalance) returned = clientBalance;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setS) {
        final maxReturn = quantity < clientBalance ? quantity : clientBalance;
        if (returned > maxReturn) returned = maxReturn;
        final newQty = quantity - returned;
        final unitPrice = double.tryParse(product.activePrice ?? '') ?? 0;
        final containerPrice = double.tryParse(container?.price ?? '') ?? 0;
        final subtotal = unitPrice * quantity + containerPrice * newQty;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(product.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Precio: \$${product.activePrice ?? "—"}',
                    style: const TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w600)),
                const Gap(12),
                _DialogStepperRow(
                  label: 'Cantidad',
                  value: quantity,
                  onDecrement: quantity > 1 ? () => setS(() => quantity--) : null,
                  onIncrement: quantity < product.stockQuantity
                      ? () => setS(() => quantity++)
                      : null,
                ),
                Text('Stock disponible: ${product.stockQuantity}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF94a3b8))),
                const Gap(12),
                _DialogStepperRow(
                  label: 'Pomas que entrega el cliente',
                  value: returned,
                  onDecrement: returned > 0 ? () => setS(() => returned--) : null,
                  onIncrement:
                      returned < maxReturn ? () => setS(() => returned++) : null,
                ),
                Text(
                  container == null
                      ? 'Este producto no tiene un envase configurado.'
                      : 'Pomas registradas del cliente: $clientBalance',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94a3b8)),
                ),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primarySubtle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pomas nuevas a cobrar',
                              style: TextStyle(fontSize: 12, color: AppColors.primaryDark)),
                          Text('$newQty',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppColors.primaryDark)),
                        ],
                      ),
                      const Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark)),
                          Text('\$${subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: AppColors.primary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                ctrl.addToCart(product,
                    quantity: quantity, returnedContainerQuantity: returned);
                Navigator.pop(ctx);
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    ),
  );
}

void showSimpleQuantityDialog(
  BuildContext context, {
  required String title,
  required String? price,
  required int maxQuantity,
  required ValueChanged<int> onConfirm,
  int initialQuantity = 1,
}) {
  int qty = initialQuantity;
  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setS) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Precio: \$${price ?? "—"}',
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w600)),
            const Gap(16),
            _DialogStepperRow(
              label: '',
              value: qty,
              onDecrement: qty > 1 ? () => setS(() => qty--) : null,
              onIncrement: qty < maxQuantity ? () => setS(() => qty++) : null,
            ),
            if (maxQuantity < 999)
              Text('Stock disponible: $maxQuantity',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF94a3b8))),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              onConfirm(qty);
              Navigator.pop(ctx);
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    ),
  );
}

class _DialogStepperRow extends StatelessWidget {
  const _DialogStepperRow({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: const Icon(Icons.remove_circle_outline,
                  color: AppColors.primary),
            ),
            SizedBox(
              width: 36,
              child: Text('$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            ),
            IconButton(
              onPressed: onIncrement,
              icon:
                  const Icon(Icons.add_circle_outline, color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Step 2: Detalle — cliente, carrito, pago, sucursal (informativa)
// ════════════════════════════════════════════════════════════════════

class _DetailStep extends ConsumerStatefulWidget {
  const _DetailStep({
    required this.client,
    required this.cart,
    required this.standaloneContainers,
    required this.paymentMethods,
    required this.paymentMethod,
    required this.observation,
    required this.scrollController,
    required this.ctrl,
    required this.total,
    required this.onBack,
    required this.onNext,
  });

  final ClientModel? client;
  final List<CartItem> cart;
  final List<StandaloneContainerItem> standaloneContainers;
  final List<PaymentMethodModel> paymentMethods;
  final String paymentMethod;
  final String observation;
  final ScrollController scrollController;
  final NewSaleController ctrl;
  final double total;
  final VoidCallback onBack, onNext;

  @override
  ConsumerState<_DetailStep> createState() => _DetailStepState();
}

class _DetailStepState extends ConsumerState<_DetailStep> {
  late final _obsCtrl = TextEditingController(text: widget.observation);

  @override
  void dispose() {
    _obsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authControllerProvider);
    final userInfo = authState.mapOrNull(authenticated: (s) => s.user);
    final branchDisplay = userInfo?.branchDisplay ?? '';
    final hasClient = widget.client != null;

    return Column(
      children: [
        Expanded(
          child: !hasClient
              // Sin cliente todavía: solo se ve el buscador/registro — el
              // resto del detalle (carrito, pago, sucursal) aparece recién
              // cuando ya hay un cliente elegido.
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClientSearchView(
                    scrollController: widget.scrollController,
                    onSelected: widget.ctrl.setClient,
                  ),
                )
              : ListView(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              // ── Cliente ────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _SectionTitle('Cliente'),
                  TextButton.icon(
                    onPressed: widget.ctrl.clearClient,
                    icon: const Icon(Icons.sync_alt, size: 16),
                    label: const Text('Cambiar', style: TextStyle(fontSize: 13)),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  title: Text(widget.client?.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    [
                      if ((widget.client?.documentNumber ?? '').isNotEmpty)
                        widget.client!.documentNumber!,
                      if ((widget.client?.mobilePhone ?? '').isNotEmpty)
                        widget.client!.mobilePhone,
                    ].join(' · '),
                  ),
                ),
              ),
              const Gap(16),

              // ── Sucursal (informativa, no editable) ─────────────────
              if (branchDisplay.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.storefront_outlined,
                          size: 18, color: colorScheme.onSurfaceVariant),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          'Sucursal: $branchDisplay',
                          style: TextStyle(
                              fontSize: 13, color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
              ],

              // ── Productos en el carrito ───────────────────────────
              if (widget.cart.isNotEmpty) ...[
                const _SectionTitle('Productos'),
                const Gap(8),
                ...widget.cart.map((item) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item.productName}  x${item.quantity}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 13),
                                  ),
                                ),
                                Text('\$${item.lineTotal.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700)),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      size: 18, color: AppColors.error),
                                  onPressed: () =>
                                      widget.ctrl.removeFromCart(item.productId),
                                ),
                              ],
                            ),
                            if (item.isReturnable)
                              Text(
                                item.returnedContainerQuantity > 0
                                    ? 'Recibe ${item.returnedContainerQuantity} · '
                                        'Nuevas ${item.newContainerQuantity}'
                                    : 'Todas nuevas (${item.newContainerQuantity})',
                                style: TextStyle(
                                    fontSize: 12, color: colorScheme.onSurfaceVariant),
                              ),
                          ],
                        ),
                      ),
                    )),
                const Gap(8),
              ],

              // ── Envases sueltos ────────────────────────────────────
              if (widget.standaloneContainers.isNotEmpty) ...[
                const _SectionTitle('Envases / Pomas'),
                const Gap(8),
                ...widget.standaloneContainers.map((c) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        dense: true,
                        title: Text('${c.containerTypeName}  x${c.quantity}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('\$${c.subtotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700)),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: AppColors.error),
                              onPressed: () => widget.ctrl
                                  .removeStandaloneContainer(c.containerTypeId),
                            ),
                          ],
                        ),
                      ),
                    )),
                const Gap(16),
              ],

              // ── Método de pago ────────────────────────────────────
              const _SectionTitle('Método de pago'),
              const Gap(8),
              MgDropdown<String>(
                value: widget.paymentMethod.isNotEmpty ? widget.paymentMethod : null,
                items: (widget.paymentMethods.isNotEmpty
                        ? widget.paymentMethods
                        : const [PaymentMethodModel(value: 'EFECTIVO', label: 'Efectivo')])
                    .map((m) => MgDropdownItem(value: m.value, label: m.label))
                    .toList(),
                onChanged: (v) {
                  if (v != null) widget.ctrl.setPaymentMethod(v);
                },
              ),
              const Gap(16),

              MgInput(
                controller: _obsCtrl,
                label: 'Observación (opcional)',
                prefixIcon: Icons.note_outlined,
                maxLines: 2,
                onChanged: widget.ctrl.setObservation,
              ),
              const Gap(16),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
          ),
          child: Row(
            children: [
              Expanded(child: MgBtn(label: 'Atrás', isOutline: true, onTap: widget.onBack)),
              const Gap(12),
              Expanded(
                flex: 2,
                child: MgBtn(
                  label: hasClient
                      ? 'Continuar — \$${widget.total.toStringAsFixed(2)}'
                      : 'Selecciona un cliente',
                  onTap: hasClient ? widget.onNext : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Step 3: Confirmación
// ════════════════════════════════════════════════════════════════════

class _ConfirmStep extends StatelessWidget {
  const _ConfirmStep({
    required this.client,
    required this.cart,
    required this.standaloneContainers,
    required this.productsTotal,
    required this.newContainersTotal,
    required this.total,
    required this.paymentMethod,
    required this.submitting,
    required this.onBack,
    required this.onConfirm,
  });

  final ClientModel? client;
  final List<CartItem> cart;
  final List<StandaloneContainerItem> standaloneContainers;
  final double productsTotal, newContainersTotal, total;
  final String paymentMethod;
  final bool submitting;
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final returnedCount = cart.fold<int>(
        0, (sum, c) => sum + (c.isReturnable ? c.returnedContainerQuantity : 0));

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Center(
                child: Icon(Icons.shopping_cart_checkout,
                    size: 56, color: AppColors.primary),
              ),
              const Gap(12),
              const Center(
                child: Text('Confirmar venta',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              const Gap(20),
              _InfoRow(label: 'Cliente', value: client?.name ?? '—'),
              _InfoRow(
                  label: 'Productos',
                  value: '\$${productsTotal.toStringAsFixed(2)}'),
              if (newContainersTotal > 0)
                _InfoRow(
                    label: 'Envases nuevos',
                    value: '\$${newContainersTotal.toStringAsFixed(2)}'),
              if (returnedCount > 0)
                _InfoRow(
                    label: 'Envases recibidos (intercambio)',
                    value: '$returnedCount · \$0.00'),
              _InfoRow(label: 'Pago', value: paymentMethod),
              const Divider(height: 24),
              _InfoRow(
                  label: 'Total',
                  value: '\$${total.toStringAsFixed(2)}',
                  highlight: true),
              const Gap(24),
              Text(
                'Al confirmar, se registrará la venta y se descontará el stock automáticamente.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: MgBtn(
                    label: 'Atrás',
                    isOutline: true,
                    onTap: submitting ? null : onBack),
              ),
              const Gap(12),
              Expanded(
                flex: 2,
                child: MgBtn(
                  label: 'Confirmar venta',
                  isLoading: submitting,
                  onTap: submitting ? null : onConfirm,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Widgets auxiliares
// ════════════════════════════════════════════════════════════════════

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15));
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.highlight = false});

  final String label, value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: highlight ? 18 : 14,
              color: highlight ? AppColors.primary : colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
