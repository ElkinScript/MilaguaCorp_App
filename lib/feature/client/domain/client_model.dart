// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_model.freezed.dart';
part 'client_model.g.dart';

// Tipos de documento — reflejan Client.DocumentType (TextChoices) del backend.
class ClientDocumentType {
  ClientDocumentType._();
  static const cedula = 'CEDULA';
  static const ruc = 'RUC';
  static const passport = 'PASSPORT';
  static const other = 'OTHER';

  static const values = [cedula, ruc, passport, other];

  static String label(String value) => switch (value) {
        cedula => 'Cédula',
        ruc => 'RUC',
        passport => 'Pasaporte',
        _ => 'Otro',
      };
}

@freezed
class ClientModel with _$ClientModel {
  const factory ClientModel({
    required int id,
    @JsonKey(name: 'document_type') @Default(ClientDocumentType.cedula) String documentType,
    @JsonKey(name: 'document_number') String? documentNumber,
    @Default('') String name,
    @Default('') String phone,
    @JsonKey(name: 'mobile_phone') @Default('') String mobilePhone,
    @Default('') String email,
    @Default(true) bool state,
    @JsonKey(name: 'primary_address') ClientAddressModel? primaryAddress,
    @Default([]) List<ClientContainerBalanceModel> containers,
  }) = _ClientModel;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}

extension ClientModelX on ClientModel {
  /// Total de pomas que el sistema le reconoce al cliente, sumando todos
  /// los tipos — útil para un badge rápido en la lista de búsqueda.
  int get totalContainers =>
      containers.fold(0, (sum, c) => sum + c.quantity);

  int balanceFor(int containerTypeId) => containers
      .firstWhere(
        (c) => c.containerType?.id == containerTypeId,
        orElse: () => const ClientContainerBalanceModel(quantity: 0),
      )
      .quantity;
}

@freezed
class ClientAddressModel with _$ClientAddressModel {
  const factory ClientAddressModel({
    int? id,
    @Default('') String label,
    @JsonKey(name: 'main_street') @Default('') String mainStreet,
    @JsonKey(name: 'secondary_street') @Default('') String secondaryStreet,
    @Default('') String reference,
    @Default('') String city,
    @JsonKey(name: 'is_primary') @Default(false) bool isPrimary,
  }) = _ClientAddressModel;

  factory ClientAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ClientAddressModelFromJson(json);
}

extension ClientAddressModelX on ClientAddressModel {
  String get summary =>
      [mainStreet, secondaryStreet].where((s) => s.isNotEmpty).join(' y ');
}

// container_type anidado en el saldo de pomas del cliente — mismo shape que
// ContainerType.to_json() (NO to_json_api(), que usa la clave "price" en
// vez de "active_price" — ver core/container/models/container_type).
@freezed
class ClientContainerBalanceModel with _$ClientContainerBalanceModel {
  const factory ClientContainerBalanceModel({
    @JsonKey(name: 'container_type') ClientContainerTypeModel? containerType,
    @Default(0) int quantity,
  }) = _ClientContainerBalanceModel;

  factory ClientContainerBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$ClientContainerBalanceModelFromJson(json);
}

@freezed
class ClientContainerTypeModel with _$ClientContainerTypeModel {
  const factory ClientContainerTypeModel({
    required int id,
    @Default('') String name,
    @Default('') String code,
    @JsonKey(name: 'active_price') String? activePrice,
  }) = _ClientContainerTypeModel;

  factory ClientContainerTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ClientContainerTypeModelFromJson(json);
}

// Datos para registrar un cliente nuevo (POST /api/client/).
@freezed
class NewClientInput with _$NewClientInput {
  const factory NewClientInput({
    @Default(ClientDocumentType.cedula) String documentType,
    String? documentNumber,
    required String name,
    @Default('') String phone,
    @Default('') String mobilePhone,
    @Default('') String email,
  }) = _NewClientInput;
}

extension NewClientInputX on NewClientInput {
  Map<String, dynamic> toRequestJson() => {
        'document_type': documentType,
        if (documentNumber != null && documentNumber!.trim().isNotEmpty)
          'document_number': documentNumber!.trim(),
        'name': name.trim(),
        'phone': phone.trim(),
        'mobile_phone': mobilePhone.trim(),
        'email': email.trim(),
      };
}
