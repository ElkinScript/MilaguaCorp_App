import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../feature/proforma/view/widget/proforma_screen.dart';
import '../../domain/sale_model.dart';
import '../controller/sale_controller.dart';

import '../../../../core/helpers/app_colors.dart';

class SaleScreen extends ConsumerWidget {
  static const routeName = '/sales';

  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(saleControllerProvider);
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return RefreshIndicator(
      onRefresh: () => ref.read(saleControllerProvider.notifier).load(),
      color: AppColors.primary,
      child: state.when(
        initial: () => const SizedBox.shrink(),
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
                    size: 48, color: Color(0xFFef4444)),
                const Gap(16),
                Text(msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted)),
                const Gap(16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(saleControllerProvider.notifier).load(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        loaded: (sales) => sales.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 64, color: muted),
                    const Gap(16),
                    Text(
                      'No hay ventas registradas',
                      style: TextStyle(color: muted),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: sales.length,
                separatorBuilder: (_, __) => const Gap(8),
                itemBuilder: (context, index) =>
                    _SaleCard(sale: sales[index]),
              ),
      ),
    );
  }
}

class _SaleCard extends StatelessWidget {
  const _SaleCard({required this.sale});

  final SaleModel sale;

  @override
  Widget build(BuildContext context) {
    final clientName = sale.client?.name.isNotEmpty == true
        ? sale.client!.name
        : 'Sin cliente';
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clientName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    sale.saleDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (sale.branchName.isNotEmpty) ...[
                    const Gap(2),
                    Text(
                      sale.branchName,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${sale.total}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(4),
                if (sale.paymentMethodDisplay.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      sale.paymentMethodDisplay,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                const Gap(4),
                GestureDetector(
                  onTap: () => context.push(
                    ProformaScreen.routeName,
                    extra: sale,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_outlined,
                          size: 14, color: colorScheme.onSurfaceVariant),
                      const Gap(2),
                      Text(
                        'Ver proforma',
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
