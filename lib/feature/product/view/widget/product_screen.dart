import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../domain/product_model.dart';
import '../controller/product_controller.dart';

class ProductScreen extends ConsumerWidget {
  static const routeName = '/products';

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productControllerProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(productControllerProvider.notifier).load(),
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
                      ref.read(productControllerProvider.notifier).load(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        loaded: (products) => products.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_2_outlined,
                        size: 64, color: Color(0xFF94a3b8)),
                    Gap(16),
                    Text(
                      'No hay productos disponibles',
                      style: TextStyle(color: Color(0xFF64748b)),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                separatorBuilder: (_, __) => const Gap(8),
                itemBuilder: (context, index) =>
                    _ProductCard(product: products[index]),
              ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final typeName = product.productType?.name ?? '';
    final price = product.activePrice ?? '—';
    final stock = product.stockQuantity;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFb3e8f5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.water_drop,
                  color: Color(0xFF0ea5c8), size: 24),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1e293b),
                    ),
                  ),
                  if (typeName.isNotEmpty) ...[
                    const Gap(2),
                    Text(
                      typeName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748b),
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
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0ea5c8),
                  ),
                ),
                const Gap(4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: stock > 0
                        ? const Color(0x1F22c55e)
                        : const Color(0x1Fef4444),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Stock: $stock',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: stock > 0
                          ? const Color(0xFF22c55e)
                          : const Color(0xFFef4444),
                    ),
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
