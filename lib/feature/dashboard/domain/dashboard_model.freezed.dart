// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) {
  return _DashboardModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardModel {
  @JsonKey(name: 'today')
  DashboardPeriod get today => throw _privateConstructorUsedError;
  @JsonKey(name: 'week')
  DashboardPeriod get week => throw _privateConstructorUsedError;
  @JsonKey(name: 'month')
  DashboardMonth get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_products')
  List<TopProduct> get topProducts => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_sales')
  List<RecentSale> get recentSales => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardModelCopyWith<DashboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardModelCopyWith<$Res> {
  factory $DashboardModelCopyWith(
          DashboardModel value, $Res Function(DashboardModel) then) =
      _$DashboardModelCopyWithImpl<$Res, DashboardModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'today') DashboardPeriod today,
      @JsonKey(name: 'week') DashboardPeriod week,
      @JsonKey(name: 'month') DashboardMonth month,
      @JsonKey(name: 'top_products') List<TopProduct> topProducts,
      @JsonKey(name: 'recent_sales') List<RecentSale> recentSales});

  $DashboardPeriodCopyWith<$Res> get today;
  $DashboardPeriodCopyWith<$Res> get week;
  $DashboardMonthCopyWith<$Res> get month;
}

/// @nodoc
class _$DashboardModelCopyWithImpl<$Res, $Val extends DashboardModel>
    implements $DashboardModelCopyWith<$Res> {
  _$DashboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? today = null,
    Object? week = null,
    Object? month = null,
    Object? topProducts = null,
    Object? recentSales = null,
  }) {
    return _then(_value.copyWith(
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as DashboardPeriod,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as DashboardPeriod,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DashboardMonth,
      topProducts: null == topProducts
          ? _value.topProducts
          : topProducts // ignore: cast_nullable_to_non_nullable
              as List<TopProduct>,
      recentSales: null == recentSales
          ? _value.recentSales
          : recentSales // ignore: cast_nullable_to_non_nullable
              as List<RecentSale>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardPeriodCopyWith<$Res> get today {
    return $DashboardPeriodCopyWith<$Res>(_value.today, (value) {
      return _then(_value.copyWith(today: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardPeriodCopyWith<$Res> get week {
    return $DashboardPeriodCopyWith<$Res>(_value.week, (value) {
      return _then(_value.copyWith(week: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DashboardMonthCopyWith<$Res> get month {
    return $DashboardMonthCopyWith<$Res>(_value.month, (value) {
      return _then(_value.copyWith(month: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardModelImplCopyWith<$Res>
    implements $DashboardModelCopyWith<$Res> {
  factory _$$DashboardModelImplCopyWith(_$DashboardModelImpl value,
          $Res Function(_$DashboardModelImpl) then) =
      __$$DashboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'today') DashboardPeriod today,
      @JsonKey(name: 'week') DashboardPeriod week,
      @JsonKey(name: 'month') DashboardMonth month,
      @JsonKey(name: 'top_products') List<TopProduct> topProducts,
      @JsonKey(name: 'recent_sales') List<RecentSale> recentSales});

  @override
  $DashboardPeriodCopyWith<$Res> get today;
  @override
  $DashboardPeriodCopyWith<$Res> get week;
  @override
  $DashboardMonthCopyWith<$Res> get month;
}

/// @nodoc
class __$$DashboardModelImplCopyWithImpl<$Res>
    extends _$DashboardModelCopyWithImpl<$Res, _$DashboardModelImpl>
    implements _$$DashboardModelImplCopyWith<$Res> {
  __$$DashboardModelImplCopyWithImpl(
      _$DashboardModelImpl _value, $Res Function(_$DashboardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? today = null,
    Object? week = null,
    Object? month = null,
    Object? topProducts = null,
    Object? recentSales = null,
  }) {
    return _then(_$DashboardModelImpl(
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as DashboardPeriod,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as DashboardPeriod,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DashboardMonth,
      topProducts: null == topProducts
          ? _value._topProducts
          : topProducts // ignore: cast_nullable_to_non_nullable
              as List<TopProduct>,
      recentSales: null == recentSales
          ? _value._recentSales
          : recentSales // ignore: cast_nullable_to_non_nullable
              as List<RecentSale>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardModelImpl implements _DashboardModel {
  const _$DashboardModelImpl(
      {@JsonKey(name: 'today') this.today = const DashboardPeriod(),
      @JsonKey(name: 'week') this.week = const DashboardPeriod(),
      @JsonKey(name: 'month') this.month = const DashboardMonth(),
      @JsonKey(name: 'top_products')
      final List<TopProduct> topProducts = const [],
      @JsonKey(name: 'recent_sales')
      final List<RecentSale> recentSales = const []})
      : _topProducts = topProducts,
        _recentSales = recentSales;

  factory _$DashboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardModelImplFromJson(json);

  @override
  @JsonKey(name: 'today')
  final DashboardPeriod today;
  @override
  @JsonKey(name: 'week')
  final DashboardPeriod week;
  @override
  @JsonKey(name: 'month')
  final DashboardMonth month;
  final List<TopProduct> _topProducts;
  @override
  @JsonKey(name: 'top_products')
  List<TopProduct> get topProducts {
    if (_topProducts is EqualUnmodifiableListView) return _topProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topProducts);
  }

  final List<RecentSale> _recentSales;
  @override
  @JsonKey(name: 'recent_sales')
  List<RecentSale> get recentSales {
    if (_recentSales is EqualUnmodifiableListView) return _recentSales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentSales);
  }

  @override
  String toString() {
    return 'DashboardModel(today: $today, week: $week, month: $month, topProducts: $topProducts, recentSales: $recentSales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardModelImpl &&
            (identical(other.today, today) || other.today == today) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.month, month) || other.month == month) &&
            const DeepCollectionEquality()
                .equals(other._topProducts, _topProducts) &&
            const DeepCollectionEquality()
                .equals(other._recentSales, _recentSales));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      today,
      week,
      month,
      const DeepCollectionEquality().hash(_topProducts),
      const DeepCollectionEquality().hash(_recentSales));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      __$$DashboardModelImplCopyWithImpl<_$DashboardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardModel implements DashboardModel {
  const factory _DashboardModel(
          {@JsonKey(name: 'today') final DashboardPeriod today,
          @JsonKey(name: 'week') final DashboardPeriod week,
          @JsonKey(name: 'month') final DashboardMonth month,
          @JsonKey(name: 'top_products') final List<TopProduct> topProducts,
          @JsonKey(name: 'recent_sales') final List<RecentSale> recentSales}) =
      _$DashboardModelImpl;

  factory _DashboardModel.fromJson(Map<String, dynamic> json) =
      _$DashboardModelImpl.fromJson;

  @override
  @JsonKey(name: 'today')
  DashboardPeriod get today;
  @override
  @JsonKey(name: 'week')
  DashboardPeriod get week;
  @override
  @JsonKey(name: 'month')
  DashboardMonth get month;
  @override
  @JsonKey(name: 'top_products')
  List<TopProduct> get topProducts;
  @override
  @JsonKey(name: 'recent_sales')
  List<RecentSale> get recentSales;
  @override
  @JsonKey(ignore: true)
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardPeriod _$DashboardPeriodFromJson(Map<String, dynamic> json) {
  return _DashboardPeriod.fromJson(json);
}

/// @nodoc
mixin _$DashboardPeriod {
  double get total => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardPeriodCopyWith<DashboardPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardPeriodCopyWith<$Res> {
  factory $DashboardPeriodCopyWith(
          DashboardPeriod value, $Res Function(DashboardPeriod) then) =
      _$DashboardPeriodCopyWithImpl<$Res, DashboardPeriod>;
  @useResult
  $Res call({double total, int count});
}

/// @nodoc
class _$DashboardPeriodCopyWithImpl<$Res, $Val extends DashboardPeriod>
    implements $DashboardPeriodCopyWith<$Res> {
  _$DashboardPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardPeriodImplCopyWith<$Res>
    implements $DashboardPeriodCopyWith<$Res> {
  factory _$$DashboardPeriodImplCopyWith(_$DashboardPeriodImpl value,
          $Res Function(_$DashboardPeriodImpl) then) =
      __$$DashboardPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double total, int count});
}

/// @nodoc
class __$$DashboardPeriodImplCopyWithImpl<$Res>
    extends _$DashboardPeriodCopyWithImpl<$Res, _$DashboardPeriodImpl>
    implements _$$DashboardPeriodImplCopyWith<$Res> {
  __$$DashboardPeriodImplCopyWithImpl(
      _$DashboardPeriodImpl _value, $Res Function(_$DashboardPeriodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? count = null,
  }) {
    return _then(_$DashboardPeriodImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardPeriodImpl implements _DashboardPeriod {
  const _$DashboardPeriodImpl({this.total = 0.0, this.count = 0});

  factory _$DashboardPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardPeriodImplFromJson(json);

  @override
  @JsonKey()
  final double total;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'DashboardPeriod(total: $total, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardPeriodImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardPeriodImplCopyWith<_$DashboardPeriodImpl> get copyWith =>
      __$$DashboardPeriodImplCopyWithImpl<_$DashboardPeriodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardPeriodImplToJson(
      this,
    );
  }
}

abstract class _DashboardPeriod implements DashboardPeriod {
  const factory _DashboardPeriod({final double total, final int count}) =
      _$DashboardPeriodImpl;

  factory _DashboardPeriod.fromJson(Map<String, dynamic> json) =
      _$DashboardPeriodImpl.fromJson;

  @override
  double get total;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$DashboardPeriodImplCopyWith<_$DashboardPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardMonth _$DashboardMonthFromJson(Map<String, dynamic> json) {
  return _DashboardMonth.fromJson(json);
}

/// @nodoc
mixin _$DashboardMonth {
  double get total => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_ticket')
  double get averageTicket => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardMonthCopyWith<DashboardMonth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardMonthCopyWith<$Res> {
  factory $DashboardMonthCopyWith(
          DashboardMonth value, $Res Function(DashboardMonth) then) =
      _$DashboardMonthCopyWithImpl<$Res, DashboardMonth>;
  @useResult
  $Res call(
      {double total,
      int count,
      @JsonKey(name: 'average_ticket') double averageTicket});
}

/// @nodoc
class _$DashboardMonthCopyWithImpl<$Res, $Val extends DashboardMonth>
    implements $DashboardMonthCopyWith<$Res> {
  _$DashboardMonthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? count = null,
    Object? averageTicket = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      averageTicket: null == averageTicket
          ? _value.averageTicket
          : averageTicket // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardMonthImplCopyWith<$Res>
    implements $DashboardMonthCopyWith<$Res> {
  factory _$$DashboardMonthImplCopyWith(_$DashboardMonthImpl value,
          $Res Function(_$DashboardMonthImpl) then) =
      __$$DashboardMonthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double total,
      int count,
      @JsonKey(name: 'average_ticket') double averageTicket});
}

/// @nodoc
class __$$DashboardMonthImplCopyWithImpl<$Res>
    extends _$DashboardMonthCopyWithImpl<$Res, _$DashboardMonthImpl>
    implements _$$DashboardMonthImplCopyWith<$Res> {
  __$$DashboardMonthImplCopyWithImpl(
      _$DashboardMonthImpl _value, $Res Function(_$DashboardMonthImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? count = null,
    Object? averageTicket = null,
  }) {
    return _then(_$DashboardMonthImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      averageTicket: null == averageTicket
          ? _value.averageTicket
          : averageTicket // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardMonthImpl implements _DashboardMonth {
  const _$DashboardMonthImpl(
      {this.total = 0.0,
      this.count = 0,
      @JsonKey(name: 'average_ticket') this.averageTicket = 0.0});

  factory _$DashboardMonthImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardMonthImplFromJson(json);

  @override
  @JsonKey()
  final double total;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey(name: 'average_ticket')
  final double averageTicket;

  @override
  String toString() {
    return 'DashboardMonth(total: $total, count: $count, averageTicket: $averageTicket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardMonthImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.averageTicket, averageTicket) ||
                other.averageTicket == averageTicket));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, count, averageTicket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardMonthImplCopyWith<_$DashboardMonthImpl> get copyWith =>
      __$$DashboardMonthImplCopyWithImpl<_$DashboardMonthImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardMonthImplToJson(
      this,
    );
  }
}

abstract class _DashboardMonth implements DashboardMonth {
  const factory _DashboardMonth(
          {final double total,
          final int count,
          @JsonKey(name: 'average_ticket') final double averageTicket}) =
      _$DashboardMonthImpl;

  factory _DashboardMonth.fromJson(Map<String, dynamic> json) =
      _$DashboardMonthImpl.fromJson;

  @override
  double get total;
  @override
  int get count;
  @override
  @JsonKey(name: 'average_ticket')
  double get averageTicket;
  @override
  @JsonKey(ignore: true)
  _$$DashboardMonthImplCopyWith<_$DashboardMonthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopProduct _$TopProductFromJson(Map<String, dynamic> json) {
  return _TopProduct.fromJson(json);
}

/// @nodoc
mixin _$TopProduct {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get units => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopProductCopyWith<TopProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopProductCopyWith<$Res> {
  factory $TopProductCopyWith(
          TopProduct value, $Res Function(TopProduct) then) =
      _$TopProductCopyWithImpl<$Res, TopProduct>;
  @useResult
  $Res call({String name, String type, int units, double revenue});
}

/// @nodoc
class _$TopProductCopyWithImpl<$Res, $Val extends TopProduct>
    implements $TopProductCopyWith<$Res> {
  _$TopProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? units = null,
    Object? revenue = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopProductImplCopyWith<$Res>
    implements $TopProductCopyWith<$Res> {
  factory _$$TopProductImplCopyWith(
          _$TopProductImpl value, $Res Function(_$TopProductImpl) then) =
      __$$TopProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String type, int units, double revenue});
}

/// @nodoc
class __$$TopProductImplCopyWithImpl<$Res>
    extends _$TopProductCopyWithImpl<$Res, _$TopProductImpl>
    implements _$$TopProductImplCopyWith<$Res> {
  __$$TopProductImplCopyWithImpl(
      _$TopProductImpl _value, $Res Function(_$TopProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? units = null,
    Object? revenue = null,
  }) {
    return _then(_$TopProductImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopProductImpl implements _TopProduct {
  const _$TopProductImpl(
      {this.name = '', this.type = '', this.units = 0, this.revenue = 0.0});

  factory _$TopProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopProductImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final int units;
  @override
  @JsonKey()
  final double revenue;

  @override
  String toString() {
    return 'TopProduct(name: $name, type: $type, units: $units, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopProductImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, units, revenue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopProductImplCopyWith<_$TopProductImpl> get copyWith =>
      __$$TopProductImplCopyWithImpl<_$TopProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopProductImplToJson(
      this,
    );
  }
}

abstract class _TopProduct implements TopProduct {
  const factory _TopProduct(
      {final String name,
      final String type,
      final int units,
      final double revenue}) = _$TopProductImpl;

  factory _TopProduct.fromJson(Map<String, dynamic> json) =
      _$TopProductImpl.fromJson;

  @override
  String get name;
  @override
  String get type;
  @override
  int get units;
  @override
  double get revenue;
  @override
  @JsonKey(ignore: true)
  _$$TopProductImplCopyWith<_$TopProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentSale _$RecentSaleFromJson(Map<String, dynamic> json) {
  return _RecentSale.fromJson(json);
}

/// @nodoc
mixin _$RecentSale {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  String get saleDate => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;
  String get client => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentSaleCopyWith<RecentSale> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentSaleCopyWith<$Res> {
  factory $RecentSaleCopyWith(
          RecentSale value, $Res Function(RecentSale) then) =
      _$RecentSaleCopyWithImpl<$Res, RecentSale>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'sale_date') String saleDate,
      String branch,
      String client,
      double total,
      @JsonKey(name: 'payment_method') String paymentMethod});
}

/// @nodoc
class _$RecentSaleCopyWithImpl<$Res, $Val extends RecentSale>
    implements $RecentSaleCopyWith<$Res> {
  _$RecentSaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleDate = null,
    Object? branch = null,
    Object? client = null,
    Object? total = null,
    Object? paymentMethod = null,
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
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentSaleImplCopyWith<$Res>
    implements $RecentSaleCopyWith<$Res> {
  factory _$$RecentSaleImplCopyWith(
          _$RecentSaleImpl value, $Res Function(_$RecentSaleImpl) then) =
      __$$RecentSaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'sale_date') String saleDate,
      String branch,
      String client,
      double total,
      @JsonKey(name: 'payment_method') String paymentMethod});
}

/// @nodoc
class __$$RecentSaleImplCopyWithImpl<$Res>
    extends _$RecentSaleCopyWithImpl<$Res, _$RecentSaleImpl>
    implements _$$RecentSaleImplCopyWith<$Res> {
  __$$RecentSaleImplCopyWithImpl(
      _$RecentSaleImpl _value, $Res Function(_$RecentSaleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleDate = null,
    Object? branch = null,
    Object? client = null,
    Object? total = null,
    Object? paymentMethod = null,
  }) {
    return _then(_$RecentSaleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentSaleImpl implements _RecentSale {
  const _$RecentSaleImpl(
      {this.id = 0,
      @JsonKey(name: 'sale_date') this.saleDate = '',
      this.branch = '',
      this.client = '',
      this.total = 0.0,
      @JsonKey(name: 'payment_method') this.paymentMethod = ''});

  factory _$RecentSaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentSaleImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'sale_date')
  final String saleDate;
  @override
  @JsonKey()
  final String branch;
  @override
  @JsonKey()
  final String client;
  @override
  @JsonKey()
  final double total;
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;

  @override
  String toString() {
    return 'RecentSale(id: $id, saleDate: $saleDate, branch: $branch, client: $client, total: $total, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentSaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, saleDate, branch, client, total, paymentMethod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentSaleImplCopyWith<_$RecentSaleImpl> get copyWith =>
      __$$RecentSaleImplCopyWithImpl<_$RecentSaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentSaleImplToJson(
      this,
    );
  }
}

abstract class _RecentSale implements RecentSale {
  const factory _RecentSale(
          {final int id,
          @JsonKey(name: 'sale_date') final String saleDate,
          final String branch,
          final String client,
          final double total,
          @JsonKey(name: 'payment_method') final String paymentMethod}) =
      _$RecentSaleImpl;

  factory _RecentSale.fromJson(Map<String, dynamic> json) =
      _$RecentSaleImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'sale_date')
  String get saleDate;
  @override
  String get branch;
  @override
  String get client;
  @override
  double get total;
  @override
  @JsonKey(name: 'payment_method')
  String get paymentMethod;
  @override
  @JsonKey(ignore: true)
  _$$RecentSaleImplCopyWith<_$RecentSaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
