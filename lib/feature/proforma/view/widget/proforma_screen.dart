import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../sale/domain/sale_model.dart';

import '../../../../core/helpers/app_colors.dart';

class ProformaScreen extends StatelessWidget {
  static const routeName = '/proforma';

  const ProformaScreen({super.key, required this.sale});

  final SaleModel sale;

  @override
  Widget build(BuildContext context) {
    final clientName = sale.client?.name.isNotEmpty == true
        ? sale.client!.name
        : 'Consumidor final';
    final clientPhone =
        sale.client?.phone.isNotEmpty == true ? sale.client!.phone : '—';
    final clientEmail =
        sale.client?.email.isNotEmpty == true ? sale.client!.email : '—';
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Proforma #${sale.id}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header card — logo + proforma title
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.water_drop,
                                  color: Colors.white, size: 28),
                            ),
                            const Gap(8),
                            const Text(
                              'Milagua Corp',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'Agua purificada de calidad',
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'PROFORMA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              'N° ${sale.id.toString().padLeft(6, '0')}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              sale.saleDate,
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(12),
            // Client info card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CLIENTE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurfaceVariant,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Gap(12),
                    _DetailRow(
                        icon: Icons.person_outline,
                        label: 'Nombre',
                        value: clientName),
                    if (sale.client?.phone.isNotEmpty == true)
                      _DetailRow(
                          icon: Icons.phone_outlined,
                          label: 'Teléfono',
                          value: clientPhone),
                    if (sale.client?.email.isNotEmpty == true)
                      _DetailRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: clientEmail),
                    _DetailRow(
                        icon: Icons.store_outlined,
                        label: 'Sucursal',
                        value: sale.branchName.isNotEmpty
                            ? sale.branchName
                            : '—'),
                    _DetailRow(
                        icon: Icons.payment_outlined,
                        label: 'Pago',
                        value: sale.paymentMethodDisplay.isNotEmpty
                            ? sale.paymentMethodDisplay
                            : '—'),
                    _DetailRow(
                        icon: Icons.person_4_outlined,
                        label: 'Vendedor',
                        value: sale.employeeName.isNotEmpty
                            ? sale.employeeName
                            : '—'),
                  ],
                ),
              ),
            ),
            const Gap(12),
            // Products table card
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DETALLE DE PRODUCTOS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurfaceVariant,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Gap(12),
                    // Table header
                    const _TableHeader(),
                    Divider(color: colorScheme.outlineVariant),
                    if (sale.details.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Sin detalle de productos',
                            style: TextStyle(color: colorScheme.onSurfaceVariant),
                          ),
                        ),
                      )
                    else
                      ...sale.details.map((d) => _TableRow(detail: d)),
                    Divider(color: colorScheme.outlineVariant),
                    // Total row
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const Gap(24),
                          Text(
                            '\$${sale.total}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (sale.observation.isNotEmpty) ...[
              const Gap(12),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OBSERVACIONES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        sale.observation,
                        style: TextStyle(
                            fontSize: 14, color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Gap(24),
            // Footer
            Center(
              child: Text(
                'Documento generado por Milagua Corp App',
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Gap(4),
            Center(
              child: Text(
                'Este documento no tiene validez tributaria',
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.outline,
                ),
              ),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const Gap(8),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: muted,
    );
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text('Producto', style: style),
        ),
        SizedBox(
          width: 40,
          child: Text('Qty', textAlign: TextAlign.center, style: style),
        ),
        SizedBox(
          width: 64,
          child: Text('P.Unit.', textAlign: TextAlign.end, style: style),
        ),
        SizedBox(
          width: 72,
          child: Text('Subtotal', textAlign: TextAlign.end, style: style),
        ),
      ],
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({required this.detail});

  final SaleDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.productName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (detail.productType.isNotEmpty)
                  Text(
                    detail.productType,
                    style: TextStyle(
                        fontSize: 11, color: colorScheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '${detail.quantity}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
            ),
          ),
          SizedBox(
            width: 64,
            child: Text(
              '\$${detail.unitPrice}',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
            ),
          ),
          SizedBox(
            width: 72,
            child: Text(
              '\$${detail.subtotal}',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
