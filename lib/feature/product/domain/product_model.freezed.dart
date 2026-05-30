// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_type')
  ProductTypeModel? get productType => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_price')
  String? get activePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_recarga')
  String? get priceRecarga => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_nuevo')
  String? get priceNuevo => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity => throw _privateConstructorUsedError;
  bool get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      @JsonKey(name: 'product_type') ProductTypeModel? productType,
      @JsonKey(name: 'active_price') String? activePrice,
      @JsonKey(name: 'price_recarga') String? priceRecarga,
      @JsonKey(name: 'price_nuevo') String? priceNuevo,
      @JsonKey(name: 'stock_quantity') int stockQuantity,
      bool state});

  $ProductTypeModelCopyWith<$Res>? get productType;
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? productType = freezed,
    Object? activePrice = freezed,
    Object? priceRecarga = freezed,
    Object? priceNuevo = freezed,
    Object? stockQuantity = null,
    Object? state = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      productType: freezed == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as ProductTypeModel?,
      activePrice: freezed == activePrice
          ? _value.activePrice
          : activePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      priceRecarga: freezed == priceRecarga
          ? _value.priceRecarga
          : priceRecarga // ignore: cast_nullable_to_non_nullable
              as String?,
      priceNuevo: freezed == priceNuevo
          ? _value.priceNuevo
          : priceNuevo // ignore: cast_nullable_to_non_nullable
              as String?,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductTypeModelCopyWith<$Res>? get productType {
    if (_value.productType == null) {
      return null;
    }

    return $ProductTypeModelCopyWith<$Res>(_value.productType!, (value) {
      return _then(_value.copyWith(productType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      @JsonKey(name: 'product_type') ProductTypeModel? productType,
      @JsonKey(name: 'active_price') String? activePrice,
      @JsonKey(name: 'price_recarga') String? priceRecarga,
      @JsonKey(name: 'price_nuevo') String? priceNuevo,
      @JsonKey(name: 'stock_quantity') int stockQuantity,
      bool state});

  @override
  $ProductTypeModelCopyWith<$Res>? get productType;
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? productType = freezed,
    Object? activePrice = freezed,
    Object? priceRecarga = freezed,
    Object? priceNuevo = freezed,
    Object? stockQuantity = null,
    Object? state = null,
  }) {
    return _then(_$ProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      productType: freezed == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as ProductTypeModel?,
      activePrice: freezed == activePrice
          ? _value.activePrice
          : activePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      priceRecarga: freezed == priceRecarga
          ? _value.priceRecarga
          : priceRecarga // ignore: cast_nullable_to_non_nullable
              as String?,
      priceNuevo: freezed == priceNuevo
          ? _value.priceNuevo
          : priceNuevo // ignore: cast_nullable_to_non_nullable
              as String?,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl implements _ProductModel {
  const _$ProductModelImpl(
      {required this.id,
      this.name = '',
      this.description = '',
      @JsonKey(name: 'product_type') this.productType,
      @JsonKey(name: 'active_price') this.activePrice,
      @JsonKey(name: 'price_recarga') this.priceRecarga,
      @JsonKey(name: 'price_nuevo') this.priceNuevo,
      @JsonKey(name: 'stock_quantity') this.stockQuantity = 0,
      this.state = true});

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'product_type')
  final ProductTypeModel? productType;
  @override
  @JsonKey(name: 'active_price')
  final String? activePrice;
  @override
  @JsonKey(name: 'price_recarga')
  final String? priceRecarga;
  @override
  @JsonKey(name: 'price_nuevo')
  final String? priceNuevo;
  @override
  @JsonKey(name: 'stock_quantity')
  final int stockQuantity;
  @override
  @JsonKey()
  final bool state;

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, productType: $productType, activePrice: $activePrice, priceRecarga: $priceRecarga, priceNuevo: $priceNuevo, stockQuantity: $stockQuantity, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.activePrice, activePrice) ||
                other.activePrice == activePrice) &&
            (identical(other.priceRecarga, priceRecarga) ||
                other.priceRecarga == priceRecarga) &&
            (identical(other.priceNuevo, priceNuevo) ||
                other.priceNuevo == priceNuevo) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      productType, activePrice, priceRecarga, priceNuevo, stockQuantity, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductModel {
  const factory _ProductModel(
      {required final int id,
      final String name,
      final String description,
      @JsonKey(name: 'product_type') final ProductTypeModel? productType,
      @JsonKey(name: 'active_price') final String? activePrice,
      @JsonKey(name: 'price_recarga') final String? priceRecarga,
      @JsonKey(name: 'price_nuevo') final String? priceNuevo,
      @JsonKey(name: 'stock_quantity') final int stockQuantity,
      final bool state}) = _$ProductModelImpl;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'product_type')
  ProductTypeModel? get productType;
  @override
  @JsonKey(name: 'active_price')
  String? get activePrice;
  @override
  @JsonKey(name: 'price_recarga')
  String? get priceRecarga;
  @override
  @JsonKey(name: 'price_nuevo')
  String? get priceNuevo;
  @override
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity;
  @override
  bool get state;
  @override
  @JsonKey(ignore: true)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductTypeModel _$ProductTypeModelFromJson(Map<String, dynamic> json) {
  return _ProductTypeModel.fromJson(json);
}

/// @nodoc
mixin _$ProductTypeModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_returnable')
  bool get isReturnable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductTypeModelCopyWith<ProductTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductTypeModelCopyWith<$Res> {
  factory $ProductTypeModelCopyWith(
          ProductTypeModel value, $Res Function(ProductTypeModel) then) =
      _$ProductTypeModelCopyWithImpl<$Res, ProductTypeModel>;
  @useResult
  $Res call(
      {int id, String name, @JsonKey(name: 'is_returnable') bool isReturnable});
}

/// @nodoc
class _$ProductTypeModelCopyWithImpl<$Res, $Val extends ProductTypeModel>
    implements $ProductTypeModelCopyWith<$Res> {
  _$ProductTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isReturnable = null,
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
      isReturnable: null == isReturnable
          ? _value.isReturnable
          : isReturnable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductTypeModelImplCopyWith<$Res>
    implements $ProductTypeModelCopyWith<$Res> {
  factory _$$ProductTypeModelImplCopyWith(_$ProductTypeModelImpl value,
          $Res Function(_$ProductTypeModelImpl) then) =
      __$$ProductTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String name, @JsonKey(name: 'is_returnable') bool isReturnable});
}

/// @nodoc
class __$$ProductTypeModelImplCopyWithImpl<$Res>
    extends _$ProductTypeModelCopyWithImpl<$Res, _$ProductTypeModelImpl>
    implements _$$ProductTypeModelImplCopyWith<$Res> {
  __$$ProductTypeModelImplCopyWithImpl(_$ProductTypeModelImpl _value,
      $Res Function(_$ProductTypeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isReturnable = null,
  }) {
    return _then(_$ProductTypeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isReturnable: null == isReturnable
          ? _value.isReturnable
          : isReturnable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductTypeModelImpl implements _ProductTypeModel {
  const _$ProductTypeModelImpl(
      {this.id = 0,
      this.name = '',
      @JsonKey(name: 'is_returnable') this.isReturnable = false});

  factory _$ProductTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductTypeModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'is_returnable')
  final bool isReturnable;

  @override
  String toString() {
    return 'ProductTypeModel(id: $id, name: $name, isReturnable: $isReturnable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductTypeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isReturnable, isReturnable) ||
                other.isReturnable == isReturnable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isReturnable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductTypeModelImplCopyWith<_$ProductTypeModelImpl> get copyWith =>
      __$$ProductTypeModelImplCopyWithImpl<_$ProductTypeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductTypeModelImplToJson(
      this,
    );
  }
}

abstract class _ProductTypeModel implements ProductTypeModel {
  const factory _ProductTypeModel(
          {final int id,
          final String name,
          @JsonKey(name: 'is_returnable') final bool isReturnable}) =
      _$ProductTypeModelImpl;

  factory _ProductTypeModel.fromJson(Map<String, dynamic> json) =
      _$ProductTypeModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'is_returnable')
  bool get isReturnable;
  @override
  @JsonKey(ignore: true)
  _$$ProductTypeModelImplCopyWith<_$ProductTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
