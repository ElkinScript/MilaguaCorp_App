import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/widget/mg_widgets.dart';
import '../../domain/client_model.dart';
import '../controller/client_search_controller.dart';
import '../state/client_search_state.dart';

/// Paso "Buscar/registrar cliente" — reutilizable: se usa embebido como
/// primer paso de Nueva Venta, y sirve igual si en el futuro se necesita
/// un buscador de clientes independiente.
///
/// Flujo (doc Empleado V1, sección 38-40): el cliente es obligatorio, se
/// busca primero por cédula/nombre/teléfono; si existe se selecciona, si
/// no existe se registra ahí mismo y se continúa con ese cliente recién
/// creado — nunca queda un formulario de venta sin cliente real detrás.
class ClientSearchView extends ConsumerStatefulWidget {
  const ClientSearchView({
    super.key,
    required this.onSelected,
    this.scrollController,
  });

  final ValueChanged<ClientModel> onSelected;
  final ScrollController? scrollController;

  @override
  ConsumerState<ClientSearchView> createState() => _ClientSearchViewState();
}

class _ClientSearchViewState extends ConsumerState<ClientSearchView> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientSearchControllerProvider);
    final ctrl = ref.read(clientSearchControllerProvider.notifier);

    ref.listen<ClientSearchState>(clientSearchControllerProvider, (prev, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        MgToast.error(context, next.errorMessage!);
        ctrl.clearError();
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Cliente'),
        const Gap(4),
        Text(
          'Busca por cédula, nombre o teléfono. Toda venta necesita un cliente registrado.',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const Gap(12),
        MgInput(
          controller: _searchCtrl,
          label: 'Buscar cliente',
          hint: 'Cédula, nombre o teléfono',
          prefixIcon: Icons.search,
          onChanged: ctrl.onQueryChanged,
          textInputAction: TextInputAction.search,
        ),
        const Gap(16),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: state.showRegisterForm
                ? _RegisterForm(
                    prefillName: state.query,
                    onCancel: ctrl.closeRegisterForm,
                    onSubmit: (input) async {
                      final client = await ctrl.register(input);
                      if (client != null) widget.onSelected(client);
                    },
                    submitting: state.registering,
                  )
                : _ResultsArea(state: state, onSelected: widget.onSelected),
          ),
        ),
      ],
    );
  }
}

class _ResultsArea extends ConsumerWidget {
  const _ResultsArea({required this.state, required this.onSelected});

  final ClientSearchState state;
  final ValueChanged<ClientModel> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(clientSearchControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    if (state.searching) {
      return const Padding(
        padding: EdgeInsets.only(top: 32),
        child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    if (!state.searched) {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Icon(Icons.person_search, size: 40, color: colorScheme.onSurfaceVariant),
            const Gap(8),
            Text(
              'Escribe al menos 3 caracteres para buscar',
              style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    if (state.results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            const Icon(Icons.person_off_outlined, size: 40, color: AppColors.warning),
            const Gap(8),
            const Text(
              'No encontramos este cliente',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const Gap(16),
            MgBtn(
              label: '+ Registrar cliente nuevo',
              onTap: ctrl.openRegisterForm,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        ...state.results.map((c) => _ClientResultCard(
              client: c,
              onTap: () => onSelected(c),
            )),
        const Gap(12),
        MgBtn(
          label: '+ Registrar otro cliente',
          isOutline: true,
          onTap: ctrl.openRegisterForm,
        ),
      ],
    );
  }
}

class _ClientResultCard extends StatelessWidget {
  const _ClientResultCard({required this.client, required this.onTap});

  final ClientModel client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  client.name.isNotEmpty ? client.name[0].toUpperCase() : '?',
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(client.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    if ((client.documentNumber ?? '').isNotEmpty)
                      Text(client.documentNumber!,
                          style: TextStyle(
                              fontSize: 12, color: colorScheme.onSurfaceVariant)),
                    if (client.mobilePhone.isNotEmpty || client.phone.isNotEmpty)
                      Text(
                        client.mobilePhone.isNotEmpty
                            ? client.mobilePhone
                            : client.phone,
                        style: TextStyle(
                            fontSize: 12, color: colorScheme.onSurfaceVariant),
                      ),
                    if (client.totalContainers > 0) ...[
                      const Gap(4),
                      Wrap(
                        spacing: 4,
                        children: client.containers
                            .where((b) => b.quantity > 0)
                            .map((b) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primarySubtle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${b.containerType?.name ?? "Envase"}: ${b.quantity}',
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({
    required this.onCancel,
    required this.onSubmit,
    required this.submitting,
    this.prefillName = '',
  });

  final VoidCallback onCancel;
  final Future<void> Function(NewClientInput) onSubmit;
  final bool submitting;
  final String prefillName;

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  late final _nameCtrl = TextEditingController(
      text: RegExp(r'^\d+$').hasMatch(widget.prefillName) ? '' : widget.prefillName);
  late final _docNumberCtrl = TextEditingController(
      text: RegExp(r'^\d+$').hasMatch(widget.prefillName) ? widget.prefillName : '');
  final _phoneCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  String _documentType = ClientDocumentType.cedula;
  String? _nameError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _docNumberCtrl.dispose();
    _phoneCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = 'El nombre es obligatorio.');
      return;
    }
    setState(() => _nameError = null);
    widget.onSubmit(NewClientInput(
      documentType: _documentType,
      documentNumber: _docNumberCtrl.text.trim().isEmpty ? null : _docNumberCtrl.text.trim(),
      name: name,
      phone: _phoneCtrl.text.trim(),
      mobilePhone: _mobileCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: widget.onCancel,
              icon: const Icon(Icons.arrow_back, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const Gap(8),
            const Text('Registrar cliente nuevo',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            SizedBox(
              width: 130,
              child: MgDropdown<String>(
                label: 'Documento',
                value: _documentType,
                items: ClientDocumentType.values
                    .map((v) => MgDropdownItem(value: v, label: ClientDocumentType.label(v)))
                    .toList(),
                onChanged: (v) => setState(() => _documentType = v ?? ClientDocumentType.cedula),
              ),
            ),
            const Gap(8),
            Expanded(
              child: MgInput(
                controller: _docNumberCtrl,
                label: 'Número',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const Gap(8),
        MgInput(
          controller: _nameCtrl,
          label: 'Nombre completo',
          prefixIcon: Icons.person_outline,
          validator: (_) => _nameError,
        ),
        if (_nameError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(_nameError!,
                style: const TextStyle(color: AppColors.error, fontSize: 11)),
          ),
        const Gap(8),
        MgInput(
          controller: _mobileCtrl,
          label: 'Celular',
          prefixIcon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
        ),
        const Gap(8),
        MgInput(
          controller: _phoneCtrl,
          label: 'Teléfono (opcional)',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const Gap(8),
        MgInput(
          controller: _emailCtrl,
          label: 'Email (opcional)',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const Gap(16),
        MgBtn(
          label: 'Guardar y continuar',
          isLoading: widget.submitting,
          onTap: widget.submitting ? null : _submit,
        ),
        const Gap(16),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15));
  }
}
