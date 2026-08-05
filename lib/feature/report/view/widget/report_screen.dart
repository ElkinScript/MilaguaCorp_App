import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../domain/report_model.dart';
import '../controller/report_controller.dart';

import '../../../../core/helpers/app_colors.dart';
class ReportScreen extends ConsumerWidget {
  static const routeName = '/reports';

  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportControllerProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(reportControllerProvider.notifier).load(),
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
                    style: const TextStyle(color: Color(0xFF64748b))),
                const Gap(16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(reportControllerProvider.notifier).load(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        loaded: (data) => _ReportContent(data: data),
      ),
    );
  }
}

class _ReportContent extends StatelessWidget {
  const _ReportContent({required this.data});

  final ReportModel data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Gap(8),
        _SectionTitle(title: 'Resumen del mes'),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Ventas',
                value: data.month.count.toString(),
                icon: Icons.shopping_cart,
                color: AppColors.primary,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _StatCard(
                label: 'Total',
                value: '\$${data.month.total.toStringAsFixed(2)}',
                icon: Icons.attach_money,
                color: const Color(0xFF22c55e),
              ),
            ),
          ],
        ),
        const Gap(8),
        _TicketCard(averageTicket: data.month.averageTicket),
        const Gap(24),
        _SectionTitle(title: 'Hoy'),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Ventas hoy',
                value: data.today.count.toString(),
                icon: Icons.today,
                color: const Color(0xFF8b5cf6),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _StatCard(
                label: 'Total hoy',
                value: '\$${data.today.total.toStringAsFixed(2)}',
                icon: Icons.monetization_on_outlined,
                color: const Color(0xFFf59e0b),
              ),
            ),
          ],
        ),
        const Gap(24),
        _SectionTitle(title: 'Esta semana'),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Ventas',
                value: data.week.count.toString(),
                icon: Icons.date_range_outlined,
                color: const Color(0xFF06b6d4),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _StatCard(
                label: 'Total',
                value: '\$${data.week.total.toStringAsFixed(2)}',
                icon: Icons.trending_up,
                color: const Color(0xFF10b981),
              ),
            ),
          ],
        ),
        if (data.topProducts.isNotEmpty) ...[
          const Gap(24),
          _SectionTitle(title: 'Top Productos'),
          const Gap(12),
          ...List.generate(data.topProducts.length, (i) {
            final p = data.topProducts[i];
            final medals = ['🥇', '🥈', '🥉'];
            final medal = i < medals.length ? medals[i] : '${i + 1}.';
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _rankColor(i).withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      medal,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                title: Text(
                  p.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                subtitle: Text(
                  p.type,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF64748b)),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${p.revenue.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${p.units} uds.',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF94a3b8)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
        if (data.recentSales.isNotEmpty) ...[
          const Gap(24),
          _SectionTitle(title: 'Ventas recientes'),
          const Gap(12),
          ...data.recentSales.take(10).map((s) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.receipt, color: AppColors.primary),
                  ),
                  title: Text(
                    s.client.isNotEmpty ? s.client : 'Sin cliente',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    s.saleDate,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF94a3b8)),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${s.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      if (s.branch.isNotEmpty)
                        Text(
                          s.branch,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF94a3b8)),
                        ),
                    ],
                  ),
                ),
              )),
        ],
        const Gap(24),
      ],
    );
  }

  Color _rankColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFf59e0b);
      case 1:
        return const Color(0xFF94a3b8);
      case 2:
        return const Color(0xFFb45309);
      default:
        return AppColors.primary;
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1e293b),
          ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label, value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const Gap(8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const Gap(2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF64748b),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.averageTicket});

  final double averageTicket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.confirmation_number_outlined,
                color: AppColors.primary, size: 28),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ticket promedio',
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748b)),
                ),
                Text(
                  '\$${averageTicket.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
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
