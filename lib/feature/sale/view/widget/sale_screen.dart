import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../feature/proforma/view/widget/proforma_screen.dart';
import '../../domain/sale_model.dart';
import '../controller/sale_controller.dart';

class SaleScreen extends ConsumerWidget {
  static const routeName = '/sales';

  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(saleControllerProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(saleControllerProvider.notifier).load(),
      color: const Color(0xFF0ea5c8),
      child: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF0ea5c8)),
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
                    style: const TextStyle(color: Color(0xFF64748b))),
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
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_outlined,
                        size: 64, color: Color(0xFF94a3b8)),
                    Gap(16),
                    Text(
                      'No hay ventas registradas',
                      style: TextStyle(color: Color(0xFF64748b)),
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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1e293b),
                    ),
                  ),
                  const Gap(4),
                  Text(
                    sale.saleDate,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94a3b8),
                    ),
                  ),
                  if (sale.branchName.isNotEmpty) ...[
                    const Gap(2),
                    Text(
                      sale.branchName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94a3b8),
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
                    color: Color(0xFF0ea5c8),
                  ),
                ),
                const Gap(4),
                if (sale.paymentMethodDisplay.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0x1F0ea5c8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      sale.paymentMethodDisplay,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0ea5c8),
                      ),
                    ),
                  ),
                const Gap(4),
                GestureDetector(
                  onTap: () => context.push(
                    ProformaScreen.routeName,
                    extra: sale,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.receipt_outlined,
                          size: 14, color: Color(0xFF64748b)),
                      Gap(2),
                      Text(
                        'Ver proforma',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748b),
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
