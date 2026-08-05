import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/domain/user_model.dart';
import '../../../auth/view/controller/auth_controller.dart';
import '../../../auth/view/widget/edit_profile_bottom_sheet.dart';
import '../../../new_sale/view/widget/new_sale_bottom_sheet.dart';
import '../../../product/view/controller/product_controller.dart';
import '../../../product/view/widget/product_screen.dart';
import '../../../report/view/controller/report_controller.dart';
import '../../../report/view/widget/report_screen.dart';
import '../../../sale/view/controller/sale_controller.dart';
import '../../../sale/view/widget/sale_screen.dart';
import '../controller/dashboard_controller.dart';
import '../../../../core/helpers/app_colors.dart';
import '../../../../core/theme/theme_mode_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // 4 tabs — center FAB abre nueva venta (no es un tab)
  static const _tabs = [
    _DashboardTab(),
    SaleScreen(),
    ProductScreen(),
    ReportScreen(),
  ];

  Future<void> _openNewSale() async {
    final created = await NewSaleBottomSheet.show(context);
    if (created == true) {
      // ignore: unused_result
      ref.refresh(dashboardControllerProvider);
      // ignore: unused_result
      ref.refresh(saleControllerProvider);
    }
  }

  void _reloadCurrentTab() {
    switch (_currentIndex) {
      case 0:
        ref.read(dashboardControllerProvider.notifier).load();
        break;
      case 1:
        ref.read(saleControllerProvider.notifier).load();
        break;
      case 2:
        ref.read(productControllerProvider.notifier).load();
        break;
      case 3:
        ref.read(reportControllerProvider.notifier).load();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final userInfo = authState.mapOrNull(authenticated: (s) => s.user);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        toolbarHeight: 78,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => EditProfileBottomSheet.show(context),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                backgroundImage: (userInfo?.profilePicture ?? '').isNotEmpty
                    ? NetworkImage(userInfo!.profilePicture!)
                    : null,
                child: (userInfo?.profilePicture ?? '').isEmpty
                    ? Text(
                        userInfo?.initials ?? '?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userInfo?.displayName ?? 'Milagua Corp',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  if ((userInfo?.groupName.isNotEmpty ?? false) ||
                      (userInfo?.username.isNotEmpty ?? false)) ...[
                    const Gap(5),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (userInfo?.groupName.isNotEmpty ?? false)
                          _HeaderChip(label: userInfo!.groupName),
                        if (userInfo?.username.isNotEmpty ?? false)
                          _HeaderChip(
                            label: userInfo!.username,
                            icon: Icons.badge_outlined,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Recargar',
            onPressed: _reloadCurrentTab,
          ),
          const _ThemeModeToggle(),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        elevation: 4,
        onPressed: _openNewSale,
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 26),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Left side: Inicio + Ventas
              _NavItem(
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard,
                label: 'Inicio',
                active: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _NavItem(
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: 'Ventas',
                active: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              // Center spacer for FAB notch
              const SizedBox(width: 48),
              // Right side: Productos + Reportes
              _NavItem(
                icon: Icons.inventory_2_outlined,
                activeIcon: Icons.inventory_2,
                label: 'Productos',
                active: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _NavItem(
                icon: Icons.bar_chart_outlined,
                activeIcon: Icons.bar_chart,
                label: 'Reportes',
                active: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
// Selector de tema — un solo ícono, alterna claro/oscuro
// ════════════════════════════════════════════════════════════════════

class _ThemeModeToggle extends ConsumerWidget {
  const _ThemeModeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeControllerProvider);
    final (icon, tooltip) = switch (mode) {
      ThemeMode.light => (Icons.light_mode, 'Claro — toca para oscuro'),
      ThemeMode.dark => (Icons.dark_mode, 'Oscuro — toca para automático'),
      ThemeMode.system => (Icons.brightness_auto, 'Automático (sistema) — toca para claro'),
    };
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      tooltip: tooltip,
      onPressed: () => ref.read(themeModeControllerProvider.notifier).cycle(),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.white),
            const Gap(4),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const primary = AppColors.primary;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              active ? activeIcon : icon,
              color: active ? primary : muted,
              size: 22,
            ),
            const Gap(2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: active ? primary : muted,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
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
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant)),
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
                    color: Theme.of(context).colorScheme.onSurface,
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
                  color: AppColors.primary,
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
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const Gap(12),
              ...data.recentSales.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.primaryLight,
                        child:
                            Icon(Icons.receipt, color: AppColors.primary),
                      ),
                      title: Text(
                          s.client.isNotEmpty ? s.client : 'Sin cliente',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface)),
                      subtitle: Text(s.saleDate,
                          style: TextStyle(
                              fontSize: 12,
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant)),
                      trailing: Text(
                        '\$${s.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
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
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
