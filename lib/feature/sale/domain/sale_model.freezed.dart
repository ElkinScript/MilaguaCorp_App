// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) {
  return _SaleModel.fromJson(json);
}

/// @nodoc
mixin _$SaleModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  String get saleDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_name')
  String get branchName => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method_display')
  String get paymentMethodDisplay => throw _privateConstructorUsedError;
  String get total => throw _privateConstructorUsedError;
  String get observation => throw _privateConstructorUsedError;
  bool get state => throw _privateConstructorUsedError;
  SaleClientModel? get client => throw _privateConstructorUsedError;
  List<SaleDetailModel> get details => throw _privateConstructorUsedError;

  /// Serializes this SaleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleModelCopyWith<SaleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleModelCopyWith<$Res> {
  factory $SaleModelCopyWith(SaleModel value, $Res Function(SaleModel) then) =
      _$SaleModelCopyWithImpl<$Res, SaleModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'sale_date') String saleDate,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'branch_name') String branchName,
      @JsonKey(name: 'payment_method_display') String paymentMethodDisplay,
      String total,
      String observation,
      bool state,
      SaleClientModel? client,
      List<SaleDetailModel> details});

  $SaleClientModelCopyWith<$Res>? get client;
}

/// @nodoc
class _$SaleModelCopyWithImpl<$Res, $Val extends SaleModel>
    implements $SaleModelCopyWith<$Res> {
  _$SaleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleDate = null,
    Object? employeeName = null,
    Object? branchName = null,
    Object? paymentMethodDisplay = null,
    Object? total = null,
    Object? observation = null,
    Object? state = null,
    Object? client = freezed,
    Object? details = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: null == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethodDisplay: null == paymentMethodDisplay
          ? _value.paymentMethodDisplay
          : paymentMethodDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      observation: null == observation
          ? _value.observation
          : observation // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as SaleClientModel?,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<SaleDetailModel>,
    ) as $Val);
  }

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleClientModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $SaleClientModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleModelImplCopyWith<$Res>
    implements $SaleModelCopyWith<$Res> {
  factory _$$SaleModelImplCopyWith(
          _$SaleModelImpl value, $Res Function(_$SaleModelImpl) then) =
      __$$SaleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'sale_date') String saleDate,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'branch_name') String branchName,
      @JsonKey(name: 'payment_method_display') String paymentMethodDisplay,
      String total,
      String observation,
      bool state,
      SaleClientModel? client,
      List<SaleDetailModel> details});

  @override
  $SaleClientModelCopyWith<$Res>? get client;
}

/// @nodoc
class __$$SaleModelImplCopyWithImpl<$Res>
    extends _$SaleModelCopyWithImpl<$Res, _$SaleModelImpl>
    implements _$$SaleModelImplCopyWith<$Res> {
  __$$SaleModelImplCopyWithImpl(
      _$SaleModelImpl _value, $Res Function(_$SaleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleDate = null,
    Object? employeeName = null,
    Object? branchName = null,
    Object? paymentMethodDisplay = null,
    Object? total = null,
    Object? observation = null,
    Object? state = null,
    Object? client = freezed,
    Object? details = null,
  }) {
    return _then(_$SaleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: null == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethodDisplay: null == paymentMethodDisplay
          ? _value.paymentMethodDisplay
          : paymentMethodDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      observation: null == observation
          ? _value.observation
          : observation // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as SaleClientModel?,
      details: null == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<SaleDetailModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleModelImpl implements _SaleModel {
  const _$SaleModelImpl(
      {required this.id,
      @JsonKey(name: 'sale_date') this.saleDate = '',
      @JsonKey(name: 'employee_name') this.employeeName = '',
      @JsonKey(name: 'branch_name') this.branchName = '',
      @JsonKey(name: 'payment_method_display') this.paymentMethodDisplay = '',
      this.total = '0.00',
      this.observation = '',
      this.state = true,
      this.client = null,
      final List<SaleDetailModel> details = const []})
      : _details = details;

  factory _$SaleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'sale_date')
  final String saleDate;
  @override
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @override
  @JsonKey(name: 'branch_name')
  final String branchName;
  @override
  @JsonKey(name: 'payment_method_display')
  final String paymentMethodDisplay;
  @override
  @JsonKey()
  final String total;
  @override
  @JsonKey()
  final String observation;
  @override
  @JsonKey()
  final bool state;
  @override
  @JsonKey()
  final SaleClientModel? client;
  final List<SaleDetailModel> _details;
  @override
  @JsonKey()
  List<SaleDetailModel> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  @override
  String toString() {
    return 'SaleModel(id: $id, saleDate: $saleDate, employeeName: $employeeName, branchName: $branchName, paymentMethodDisplay: $paymentMethodDisplay, total: $total, observation: $observation, state: $state, client: $client, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.paymentMethodDisplay, paymentMethodDisplay) ||
                other.paymentMethodDisplay == paymentMethodDisplay) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.observation, observation) ||
                other.observation == observation) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.client, client) || other.client == client) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      saleDate,
      employeeName,
      branchName,
      paymentMethodDisplay,
      total,
      observation,
      state,
      client,
      const DeepCollectionEquality().hash(_details));

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleModelImplCopyWith<_$SaleModelImpl> get copyWith =>
      __$$SaleModelImplCopyWithImpl<_$SaleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleModelImplToJson(
      this,
    );
  }
}

abstract class _SaleModel implements SaleModel {
  const factory _SaleModel(
      {required final int id,
      @JsonKey(name: 'sale_date') final String saleDate,
      @JsonKey(name: 'employee_name') final String employeeName,
      @JsonKey(name: 'branch_name') final String branchName,
      @JsonKey(name: 'payment_method_display')
      final String paymentMethodDisplay,
      final String total,
      final String observation,
      final bool state,
      final SaleClientModel? client,
      final List<SaleDetailModel> details}) = _$SaleModelImpl;

  factory _SaleModel.fromJson(Map<String, dynamic> json) =
      _$SaleModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'sale_date')
  String get saleDate;
  @override
  @JsonKey(name: 'employee_name')
  String get employeeName;
  @override
  @JsonKey(name: 'branch_name')
  String get branchName;
  @override
  @JsonKey(name: 'payment_method_display')
  String get paymentMethodDisplay;
  @override
  String get total;
  @override
  String get observation;
  @override
  bool get state;
  @override
  SaleClientModel? get client;
  @override
  List<SaleDetailModel> get details;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleModelImplCopyWith<_$SaleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleClientModel _$SaleClientModelFromJson(Map<String, dynamic> json) {
  return _SaleClientModel.fromJson(json);
}

/// @nodoc
mixin _$SaleClientModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  /// Serializes this SaleClientModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleClientModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleClientModelCopyWith<SaleClientModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleClientModelCopyWith<$Res> {
  factory $SaleClientModelCopyWith(
          SaleClientModel value, $Res Function(SaleClientModel) then) =
      _$SaleClientModelCopyWithImpl<$Res, SaleClientModel>;
  @useResult
  $Res call({int id, String name, String phone, String email});
}

/// @nodoc
class _$SaleClientModelCopyWithImpl<$Res, $Val extends SaleClientModel>
    implements $SaleClientModelCopyWith<$Res> {
  _$SaleClientModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleClientModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleClientModelImplCopyWith<$Res>
    implements $SaleClientModelCopyWith<$Res> {
  factory _$$SaleClientModelImplCopyWith(_$SaleClientModelImpl value,
          $Res Function(_$SaleClientModelImpl) then) =
      __$$SaleClientModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String phone, String email});
}

/// @nodoc
class __$$SaleClientModelImplCopyWithImpl<$Res>
    extends _$SaleClientModelCopyWithImpl<$Res, _$SaleClientModelImpl>
    implements _$$SaleClientModelImplCopyWith<$Res> {
  __$$SaleClientModelImplCopyWithImpl(
      _$SaleClientModelImpl _value, $Res Function(_$SaleClientModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleClientModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? email = null,
  }) {
    return _then(_$SaleClientModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleClientModelImpl implements _SaleClientModel {
  const _$SaleClientModelImpl(
      {this.id = 0, this.name = '', this.phone = '', this.email = ''});

  factory _$SaleClientModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleClientModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String email;

  @override
  String toString() {
    return 'SaleClientModel(id: $id, name: $name, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleClientModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, email);

  /// Create a copy of SaleClientModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleClientModelImplCopyWith<_$SaleClientModelImpl> get copyWith =>
      __$$SaleClientModelImplCopyWithImpl<_$SaleClientModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleClientModelImplToJson(
      this,
    );
  }
}

abstract class _SaleClientModel implements SaleClientModel {
  const factory _SaleClientModel(
      {final int id,
      final String name,
      final String phone,
      final String email}) = _$SaleClientModelImpl;

  factory _SaleClientModel.fromJson(Map<String, dynamic> json) =
      _$SaleClientModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get phone;
  @override
  String get email;

  /// Create a copy of SaleClientModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleClientModelImplCopyWith<_$SaleClientModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleDetailModel _$SaleDetailModelFromJson(Map<String, dynamic> json) {
  return _SaleDetailModel.fromJson(json);
}

/// @nodoc
mixin _$SaleDetailModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_type')
  String get productType => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  String get unitPrice => throw _privateConstructorUsedError;
  String get subtotal => throw _privateConstructorUsedError;

  /// Serializes this SaleDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleDetailModelCopyWith<SaleDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleDetailModelCopyWith<$Res> {
  factory $SaleDetailModelCopyWith(
          SaleDetailModel value, $Res Function(SaleDetailModel) then) =
      _$SaleDetailModelCopyWithImpl<$Res, SaleDetailModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_type') String productType,
      int quantity,
      @JsonKey(name: 'unit_price') String unitPrice,
      String subtotal});
}

/// @nodoc
class _$SaleDetailModelCopyWithImpl<$Res, $Val extends SaleDetailModel>
    implements $SaleDetailModelCopyWith<$Res> {
  _$SaleDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? productType = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? subtotal = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productType: null == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleDetailModelImplCopyWith<$Res>
    implements $SaleDetailModelCopyWith<$Res> {
  factory _$$SaleDetailModelImplCopyWith(_$SaleDetailModelImpl value,
          $Res Function(_$SaleDetailModelImpl) then) =
      __$$SaleDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_type') String productType,
      int quantity,
      @JsonKey(name: 'unit_price') String unitPrice,
      String subtotal});
}

/// @nodoc
class __$$SaleDetailModelImplCopyWithImpl<$Res>
    extends _$SaleDetailModelCopyWithImpl<$Res, _$SaleDetailModelImpl>
    implements _$$SaleDetailModelImplCopyWith<$Res> {
  __$$SaleDetailModelImplCopyWithImpl(
      _$SaleDetailModelImpl _value, $Res Function(_$SaleDetailModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? productType = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? subtotal = null,
  }) {
    return _then(_$SaleDetailModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productType: null == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleDetailModelImpl implements _SaleDetailModel {
  const _$SaleDetailModelImpl(
      {this.id = 0,
      @JsonKey(name: 'product_name') this.productName = '',
      @JsonKey(name: 'product_type') this.productType = '',
      this.quantity = 0,
      @JsonKey(name: 'unit_price') this.unitPrice = '0.00',
      this.subtotal = '0.00'});

  factory _$SaleDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleDetailModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'product_type')
  final String productType;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey(name: 'unit_price')
  final String unitPrice;
  @override
  @JsonKey()
  final String subtotal;

  @override
  String toString() {
    return 'SaleDetailModel(id: $id, productName: $productName, productType: $productType, quantity: $quantity, unitPrice: $unitPrice, subtotal: $subtotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleDetailModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, productName, productType, quantity, unitPrice, subtotal);

  /// Create a copy of SaleDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleDetailModelImplCopyWith<_$SaleDetailModelImpl> get copyWith =>
      __$$SaleDetailModelImplCopyWithImpl<_$SaleDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleDetailModelImplToJson(
      this,
    );
  }
}

abstract class _SaleDetailModel implements SaleDetailModel {
  const factory _SaleDetailModel(
      {final int id,
      @JsonKey(name: 'product_name') final String productName,
      @JsonKey(name: 'product_type') final String productType,
      final int quantity,
      @JsonKey(name: 'unit_price') final String unitPrice,
      final String subtotal}) = _$SaleDetailModelImpl;

  factory _SaleDetailModel.fromJson(Map<String, dynamic> json) =
      _$SaleDetailModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'product_type')
  String get productType;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unit_price')
  String get unitPrice;
  @override
  String get subtotal;

  /// Create a copy of SaleDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleDetailModelImplCopyWith<_$SaleDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
