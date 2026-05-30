// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName =>
      throw _privateConstructorUsedError; // API returns groups as List<String> (flat names)
  List<String> get groups =>
      throw _privateConstructorUsedError; // employee_profile nested object — nullable
  @JsonKey(name: 'employee_profile')
  EmployeeProfileModel? get employeeProfile =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int id,
      String username,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      String email,
      @JsonKey(name: 'full_name') String fullName,
      List<String> groups,
      @JsonKey(name: 'employee_profile')
      EmployeeProfileModel? employeeProfile});

  $EmployeeProfileModelCopyWith<$Res>? get employeeProfile;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? fullName = null,
    Object? groups = null,
    Object? employeeProfile = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      employeeProfile: freezed == employeeProfile
          ? _value.employeeProfile
          : employeeProfile // ignore: cast_nullable_to_non_nullable
              as EmployeeProfileModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EmployeeProfileModelCopyWith<$Res>? get employeeProfile {
    if (_value.employeeProfile == null) {
      return null;
    }

    return $EmployeeProfileModelCopyWith<$Res>(_value.employeeProfile!,
        (value) {
      return _then(_value.copyWith(employeeProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String username,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      String email,
      @JsonKey(name: 'full_name') String fullName,
      List<String> groups,
      @JsonKey(name: 'employee_profile')
      EmployeeProfileModel? employeeProfile});

  @override
  $EmployeeProfileModelCopyWith<$Res>? get employeeProfile;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? fullName = null,
    Object? groups = null,
    Object? employeeProfile = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      employeeProfile: freezed == employeeProfile
          ? _value.employeeProfile
          : employeeProfile // ignore: cast_nullable_to_non_nullable
              as EmployeeProfileModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.username,
      @JsonKey(name: 'first_name') this.firstName = '',
      @JsonKey(name: 'last_name') this.lastName = '',
      this.email = '',
      @JsonKey(name: 'full_name') this.fullName = '',
      final List<String> groups = const [],
      @JsonKey(name: 'employee_profile') this.employeeProfile = null})
      : _groups = groups;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String username;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
// API returns groups as List<String> (flat names)
  final List<String> _groups;
// API returns groups as List<String> (flat names)
  @override
  @JsonKey()
  List<String> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

// employee_profile nested object — nullable
  @override
  @JsonKey(name: 'employee_profile')
  final EmployeeProfileModel? employeeProfile;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, fullName: $fullName, groups: $groups, employeeProfile: $employeeProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            (identical(other.employeeProfile, employeeProfile) ||
                other.employeeProfile == employeeProfile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      firstName,
      lastName,
      email,
      fullName,
      const DeepCollectionEquality().hash(_groups),
      employeeProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final int id,
      required final String username,
      @JsonKey(name: 'first_name') final String firstName,
      @JsonKey(name: 'last_name') final String lastName,
      final String email,
      @JsonKey(name: 'full_name') final String fullName,
      final List<String> groups,
      @JsonKey(name: 'employee_profile')
      final EmployeeProfileModel? employeeProfile}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get username;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get email;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override // API returns groups as List<String> (flat names)
  List<String> get groups;
  @override // employee_profile nested object — nullable
  @JsonKey(name: 'employee_profile')
  EmployeeProfileModel? get employeeProfile;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeeProfileModel _$EmployeeProfileModelFromJson(Map<String, dynamic> json) {
  return _EmployeeProfileModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeProfileModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_name')
  String get branchName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'identification_number')
  String get identificationNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeProfileModelCopyWith<EmployeeProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeProfileModelCopyWith<$Res> {
  factory $EmployeeProfileModelCopyWith(EmployeeProfileModel value,
          $Res Function(EmployeeProfileModel) then) =
      _$EmployeeProfileModelCopyWithImpl<$Res, EmployeeProfileModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'branch_name') String branchName,
      String phone,
      @JsonKey(name: 'identification_number') String identificationNumber});
}

/// @nodoc
class _$EmployeeProfileModelCopyWithImpl<$Res,
        $Val extends EmployeeProfileModel>
    implements $EmployeeProfileModelCopyWith<$Res> {
  _$EmployeeProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branchName = null,
    Object? phone = null,
    Object? identificationNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      branchName: null == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      identificationNumber: null == identificationNumber
          ? _value.identificationNumber
          : identificationNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeProfileModelImplCopyWith<$Res>
    implements $EmployeeProfileModelCopyWith<$Res> {
  factory _$$EmployeeProfileModelImplCopyWith(_$EmployeeProfileModelImpl value,
          $Res Function(_$EmployeeProfileModelImpl) then) =
      __$$EmployeeProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'branch_name') String branchName,
      String phone,
      @JsonKey(name: 'identification_number') String identificationNumber});
}

/// @nodoc
class __$$EmployeeProfileModelImplCopyWithImpl<$Res>
    extends _$EmployeeProfileModelCopyWithImpl<$Res, _$EmployeeProfileModelImpl>
    implements _$$EmployeeProfileModelImplCopyWith<$Res> {
  __$$EmployeeProfileModelImplCopyWithImpl(_$EmployeeProfileModelImpl _value,
      $Res Function(_$EmployeeProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branchName = null,
    Object? phone = null,
    Object? identificationNumber = null,
  }) {
    return _then(_$EmployeeProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      branchName: null == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      identificationNumber: null == identificationNumber
          ? _value.identificationNumber
          : identificationNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeProfileModelImpl implements _EmployeeProfileModel {
  const _$EmployeeProfileModelImpl(
      {required this.id,
      @JsonKey(name: 'branch_name') this.branchName = '',
      this.phone = '',
      @JsonKey(name: 'identification_number') this.identificationNumber = ''});

  factory _$EmployeeProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeProfileModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'branch_name')
  final String branchName;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey(name: 'identification_number')
  final String identificationNumber;

  @override
  String toString() {
    return 'EmployeeProfileModel(id: $id, branchName: $branchName, phone: $phone, identificationNumber: $identificationNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.identificationNumber, identificationNumber) ||
                other.identificationNumber == identificationNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, branchName, phone, identificationNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeProfileModelImplCopyWith<_$EmployeeProfileModelImpl>
      get copyWith =>
          __$$EmployeeProfileModelImplCopyWithImpl<_$EmployeeProfileModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeProfileModelImplToJson(
      this,
    );
  }
}

abstract class _EmployeeProfileModel implements EmployeeProfileModel {
  const factory _EmployeeProfileModel(
      {required final int id,
      @JsonKey(name: 'branch_name') final String branchName,
      final String phone,
      @JsonKey(name: 'identification_number')
      final String identificationNumber}) = _$EmployeeProfileModelImpl;

  factory _EmployeeProfileModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeProfileModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'branch_name')
  String get branchName;
  @override
  String get phone;
  @override
  @JsonKey(name: 'identification_number')
  String get identificationNumber;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeProfileModelImplCopyWith<_$EmployeeProfileModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
