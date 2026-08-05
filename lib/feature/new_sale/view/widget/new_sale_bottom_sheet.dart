// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/widget/mg_widgets.dart';
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

class _NewSaleBottomSheetState extends ConsumerState<NewSaleBottomSheet> {
  int _step = 0; // 0=products, 1=cart+client, 2=confirm

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newSaleControllerProvider);
    final ctrl = ref.read(newSaleControllerProvider.notifier);

    // Toast de error cuando falla el submit de la venta.
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
                        MgBtn(
                          label: 'Reintentar',
                          onTap: () => ctrl.load(),
                        ),
                      ],
                    ),
                  ),
                ),
                ready: (products, branches, cart, selectedBranch,
                    paymentMethod, clientName, clientPhone, clientEmail,
                    observation, hasContainer, submitting, success,
                    submitError) {
                  if (_step == 0) {
                    return _ProductsStep(
                      products: products,
                      cart: cart,
                      scrollController: scrollController,
                      onAdd: (p) => _showQuantityDialog(context, p, ctrl),
                      onNext: () {
                        if (cart.isNotEmpty) setState(() => _step = 1);
                      },
                      cartCount: cart.length,
                      cartTotal: ctrl.total,
                    );
                  } else if (_step == 1) {
                    return _CartStep(
                      cart: cart,
                      branches: branches,
                      selectedBranch: selectedBranch,
                      paymentMethod: paymentMethod,
                      clientName: clientName,
                      clientPhone: clientPhone,
                      clientEmail: clientEmail,
                      observation: observation,
                      hasContainer: hasContainer,
                      scrollController: scrollController,
                      ctrl: ctrl,
                      total: ctrl.total,
                      onBack: () => setState(() => _step = 0),
                      onNext: () => setState(() => _step = 2),
                    );
                  } else {
                    return _ConfirmStep(
                      cart: cart,
                      total: ctrl.total,
                      clientName: clientName,
                      paymentMethod: paymentMethod,
                      submitting: submitting,
                      onBack: () => setState(() => _step = 1),
                      onConfirm: () async {
                        final ok = await ctrl.submitSale();
                        if (ok && context.mounted) {
                          MgToast.success(context, 'Venta registrada correctamente');
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

  void _showQuantityDialog(
      BuildContext context, ProductModel product, NewSaleController ctrl) {
    int qty = 1;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: Text(
            product.name,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Precio: \$${product.activePrice ?? "—"}',
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (qty > 1) setS(() => qty--);
                    },
                    icon: const Icon(Icons.remove_circle_outline,
                        color: AppColors.primary),
                  ),
                  Text(
                    '$qty',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () {
                      if (qty < product.stockQuantity) {
                        setS(() => qty++);
                      }
                    },
                    icon: const Icon(Icons.add_circle_outline,
                        color: AppColors.primary),
                  ),
                ],
              ),
              Text(
                'Stock disponible: ${product.stockQuantity}',
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF94a3b8)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                ctrl.addToCart(product, qty);
                Navigator.pop(ctx);
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
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
    final steps = ['Productos', 'Detalle', 'Confirmar'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(steps.length, (i) {
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
                  width: 28,
                  height: 28,
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
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (i < steps.length - 1)
                  const Expanded(child: SizedBox()),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Step 0: Lista de productos
// ════════════════════════════════════════════════════════════════════

class _ProductsStep extends StatelessWidget {
  const _ProductsStep({
    required this.products,
    required this.cart,
    required this.scrollController,
    required this.onAdd,
    required this.onNext,
    required this.cartCount,
    required this.cartTotal,
  });

  final List<ProductModel> products;
  final List<CartItem> cart;
  final ScrollController scrollController;
  final void Function(ProductModel) onAdd;
  final VoidCallback onNext;
  final int cartCount;
  final double cartTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (_, __) => const Gap(8),
            itemBuilder: (_, i) {
              final p = products[i];
              final inCart = cart.any((c) => c.productId == p.id);
              return Card(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.water_drop,
                        color: AppColors.primary, size: 20),
                  ),
                  title: Text(
                    p.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: Text(
                    p.productType?.name ?? '',
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
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
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Stock: ${p.stockQuantity}',
                            style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant),
                          ),
                        ],
                      ),
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
                        onPressed: () => onAdd(p),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (cartCount > 0)
          Padding(
            padding: const EdgeInsets.all(16),
            child: MgBtn(
              label:
                  'Ver carrito ($cartCount) — \$${cartTotal.toStringAsFixed(2)}',
              icon: Icons.shopping_cart_outlined,
              onTap: onNext,
            ),
          ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Step 1: Carrito + datos del cliente
// ════════════════════════════════════════════════════════════════════

class _CartStep extends ConsumerStatefulWidget {
  const _CartStep({
    required this.cart,
    required this.branches,
    required this.selectedBranch,
    required this.paymentMethod,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.observation,
    required this.hasContainer,
    required this.scrollController,
    required this.ctrl,
    required this.total,
    required this.onBack,
    required this.onNext,
  });

  final List<CartItem> cart;
  final List<BranchModel> branches;
  final BranchModel? selectedBranch;
  final String paymentMethod;
  final String clientName, clientPhone, clientEmail, observation;
  final bool hasContainer;
  final ScrollController scrollController;
  final NewSaleController ctrl;
  final double total;
  final VoidCallback onBack, onNext;

  @override
  ConsumerState<_CartStep> createState() => _CartStepState();
}

class _CartStepState extends ConsumerState<_CartStep> {
  late final TextEditingController _nameCtrl,
      _phoneCtrl,
      _emailCtrl,
      _obsCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.clientName);
    _phoneCtrl = TextEditingController(text: widget.clientPhone);
    _emailCtrl = TextEditingController(text: widget.clientEmail);
    _obsCtrl = TextEditingController(text: widget.observation);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dropBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );
    final dropDecoration = InputDecoration(
      filled: true,
      fillColor: colorScheme.surface,
      border: dropBorder,
      enabledBorder: dropBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              // ── Productos en el carrito ───────────────────────────
              const _SectionTitle('Productos'),
              const Gap(8),
              ...widget.cart.map((item) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                Text(
                                  '\$${item.unitPrice} c/u',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.remove, size: 18),
                                onPressed: () =>
                                    widget.ctrl.updateQuantity(
                                        item.productId,
                                        item.quantity - 1),
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 18),
                                onPressed: () =>
                                    widget.ctrl.updateQuantity(
                                        item.productId,
                                        item.quantity + 1),
                              ),
                              Text(
                                '\$${item.subtotalFormatted}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),

              const Gap(16),

              // ── Sucursal ──────────────────────────────────────────
              if (widget.branches.isNotEmpty) ...[
                const _SectionTitle('Sucursal'),
                const Gap(8),
                DropdownButtonFormField<BranchModel>(
                  value: widget.selectedBranch,
                  decoration: dropDecoration,
                  items: widget.branches
                      .map((b) => DropdownMenuItem(
                            value: b,
                            child: Text(b.name),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) widget.ctrl.selectBranch(v);
                  },
                ),
                const Gap(16),
              ],

              // ── Método de pago ────────────────────────────────────
              const _SectionTitle('Método de pago'),
              const Gap(8),
              DropdownButtonFormField<String>(
                value: widget.paymentMethod,
                decoration: dropDecoration,
                items: const [
                  DropdownMenuItem(
                      value: 'efectivo', child: Text('Efectivo')),
                  DropdownMenuItem(
                      value: 'transferencia',
                      child: Text('Transferencia')),
                  DropdownMenuItem(
                      value: 'tarjeta', child: Text('Tarjeta')),
                ],
                onChanged: (v) {
                  if (v != null) widget.ctrl.setPaymentMethod(v);
                },
              ),

              const Gap(16),

              // ── Poma ──────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: widget.hasContainer
                      ? AppColors.primarySubtle
                      : const Color(0xFFfef3c7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.hasContainer
                        ? AppColors.primary
                        : const Color(0xFFf59e0b),
                    width: 1.2,
                  ),
                ),
                child: SwitchListTile(
                  value: widget.hasContainer,
                  activeColor: AppColors.primary,
                  inactiveThumbColor: const Color(0xFFf59e0b),
                  inactiveTrackColor: const Color(0xFFfde68a),
                  onChanged: widget.ctrl.setHasContainer,
                  title: Text(
                    widget.hasContainer
                        ? 'Cliente tiene poma propia'
                        : 'Cliente sin poma propia',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: widget.hasContainer
                          ? const Color(0xFF0369a1)
                          : const Color(0xFF92400e),
                    ),
                  ),
                  subtitle: Text(
                    widget.hasContainer
                        ? 'Precio: solo recarga de agua'
                        : 'Precio: poma + agua incluidas',
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.hasContainer
                          ? AppColors.primary
                          : const Color(0xFF92400e),
                    ),
                  ),
                ),
              ),

              const Gap(16),

              // ── Datos del cliente ─────────────────────────────────
              const _SectionTitle('Cliente (opcional)'),
              const Gap(8),
              MgInput(
                controller: _nameCtrl,
                label: 'Nombre',
                prefixIcon: Icons.person_outline,
                onChanged: widget.ctrl.setClientName,
                textInputAction: TextInputAction.next,
              ),
              const Gap(8),
              MgInput(
                controller: _phoneCtrl,
                label: 'Teléfono',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                onChanged: widget.ctrl.setClientPhone,
                textInputAction: TextInputAction.next,
              ),
              const Gap(8),
              MgInput(
                controller: _emailCtrl,
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: widget.ctrl.setClientEmail,
                textInputAction: TextInputAction.next,
              ),
              const Gap(8),
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

        // ── Botones navegación ─────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
          ),
          child: Row(
            children: [
              Expanded(
                child: MgBtn(
                  label: 'Atrás',
                  isOutline: true,
                  onTap: widget.onBack,
                ),
              ),
              const Gap(12),
              Expanded(
                flex: 2,
                child: MgBtn(
                  label:
                      'Continuar — \$${widget.total.toStringAsFixed(2)}',
                  onTap: widget.onNext,
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
// Step 2: Confirmación
// ════════════════════════════════════════════════════════════════════

class _ConfirmStep extends StatelessWidget {
  const _ConfirmStep({
    required this.cart,
    required this.total,
    required this.clientName,
    required this.paymentMethod,
    required this.submitting,
    required this.onBack,
    required this.onConfirm,
  });

  final List<CartItem> cart;
  final double total;
  final String clientName, paymentMethod;
  final bool submitting;
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Center(
                child: Icon(Icons.shopping_cart_checkout,
                    size: 64, color: AppColors.primary),
              ),
              const Gap(16),
              const Center(
                child: Text(
                  'Confirmar venta',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const Gap(24),
              _InfoRow(
                  label: 'Productos',
                  value: '${cart.length} ítem(s)'),
              _InfoRow(
                  label: 'Total',
                  value: '\$${total.toStringAsFixed(2)}',
                  highlight: true),
              _InfoRow(
                  label: 'Cliente',
                  value: clientName.isNotEmpty
                      ? clientName
                      : 'Sin cliente'),
              _InfoRow(label: 'Pago', value: paymentMethod),
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
                  onTap: submitting ? null : onBack,
                ),
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
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

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
