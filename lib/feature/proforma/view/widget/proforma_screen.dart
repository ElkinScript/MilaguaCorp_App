import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../sale/domain/sale_model.dart';

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

    return Scaffold(
      backgroundColor: const Color(0xFFf1f5f9),
      appBar: AppBar(
        title: Text(
          'Proforma #${sale.id}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF0ea5c8),
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
                                color: const Color(0xFF0ea5c8),
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
                                color: Color(0xFF0ea5c8),
                              ),
                            ),
                            const Text(
                              'Agua purificada de calidad',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF94a3b8)),
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
                                color: const Color(0xFF0ea5c8),
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
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF475569),
                              ),
                            ),
                            Text(
                              sale.saleDate,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94a3b8),
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
                    const Text(
                      'CLIENTE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF94a3b8),
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
                    const Text(
                      'DETALLE DE PRODUCTOS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF94a3b8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Gap(12),
                    // Table header
                    const _TableHeader(),
                    const Divider(color: Color(0xFFe2e8f0)),
                    if (sale.details.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Sin detalle de productos',
                            style:
                                TextStyle(color: Color(0xFF94a3b8)),
                          ),
                        ),
                      )
                    else
                      ...sale.details.map((d) => _TableRow(detail: d)),
                    const Divider(color: Color(0xFFe2e8f0)),
                    // Total row
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'TOTAL',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Color(0xFF1e293b),
                            ),
                          ),
                          const Gap(24),
                          Text(
                            '\$${sale.total}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: Color(0xFF0ea5c8),
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
                      const Text(
                        'OBSERVACIONES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF94a3b8),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        sale.observation,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF475569)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Gap(24),
            // Footer
            const Center(
              child: Text(
                'Documento generado por Milagua Corp App',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94a3b8),
                ),
              ),
            ),
            const Gap(4),
            const Center(
              child: Text(
                'Este documento no tiene validez tributaria',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFFcbd5e1),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF0ea5c8)),
          const Gap(8),
          Text(
            '$label: ',
            style: const TextStyle(
                fontSize: 13, color: Color(0xFF64748b)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1e293b),
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
    return const Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            'Producto',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748b),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            'Qty',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748b),
            ),
          ),
        ),
        SizedBox(
          width: 64,
          child: Text(
            'P.Unit.',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748b),
            ),
          ),
        ),
        SizedBox(
          width: 72,
          child: Text(
            'Subtotal',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748b),
            ),
          ),
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
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1e293b),
                  ),
                ),
                if (detail.productType.isNotEmpty)
                  Text(
                    detail.productType,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF94a3b8)),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '${detail.quantity}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF475569)),
            ),
          ),
          SizedBox(
            width: 64,
            child: Text(
              '\$${detail.unitPrice}',
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF475569)),
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
                color: Color(0xFF0ea5c8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
