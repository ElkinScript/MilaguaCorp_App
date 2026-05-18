import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/view/controller/auth_controller.dart';
import '../../../product/view/widget/product_screen.dart';
import '../../../sale/view/widget/sale_screen.dart';
import '../controller/dashboard_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  static const _tabs = [
    _DashboardTab(),
    SaleScreen(),
    ProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milagua Corp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              final router = GoRouter.of(context);
              await ref.read(authControllerProvider.notifier).logout();
              if (!mounted) return;
              router.go('/login');
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: const Color(0xFF0ea5c8),
        unselectedItemColor: const Color(0xFF94a3b8),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Ventas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Productos',
          ),
        ],
      ),
    );
  }
}

class _DashboardTab extends ConsumerWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(dashboardControllerProvider.notifier).load(),
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
                      ref.read(dashboardControllerProvider.notifier).load(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        loaded: (data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Gap(8),
            Text(
              'Resumen del mes',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1e293b),
                  ),
            ),
            const Gap(16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _SummaryCard(
                  label: 'Ventas del mes',
                  value: data.month.count.toString(),
                  icon: Icons.shopping_cart,
                  color: const Color(0xFF0ea5c8),
                ),
                _SummaryCard(
                  label: 'Total del mes',
                  value: '\$${data.month.total.toStringAsFixed(2)}',
                  icon: Icons.attach_money,
                  color: const Color(0xFF22c55e),
                ),
                _SummaryCard(
                  label: 'Ventas hoy',
                  value: data.today.count.toString(),
                  icon: Icons.today,
                  color: const Color(0xFF8b5cf6),
                ),
                _SummaryCard(
                  label: 'Total hoy',
                  value: '\$${data.today.total.toStringAsFixed(2)}',
                  icon: Icons.monetization_on_outlined,
                  color: const Color(0xFFf59e0b),
                ),
              ],
            ),
            if (data.recentSales.isNotEmpty) ...[
              const Gap(24),
              Text(
                'Ventas recientes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1e293b),
                    ),
              ),
              const Gap(12),
              ...data.recentSales.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFb3e8f5),
                        child:
                            Icon(Icons.receipt, color: Color(0xFF0ea5c8)),
                      ),
                      title: Text(s.client.isNotEmpty ? s.client : 'Sin cliente',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      subtitle: Text(s.saleDate,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF94a3b8))),
                      trailing: Text(
                        '\$${s.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0ea5c8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const Gap(24),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748b),
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
