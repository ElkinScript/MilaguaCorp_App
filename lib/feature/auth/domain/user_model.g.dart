// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      employeeProfile: json['employee_profile'] == null
          ? null
          : EmployeeProfileModel.fromJson(
              json['employee_profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'full_name': instance.fullName,
      'groups': instance.groups,
      'employee_profile': instance.employeeProfile,
    };

_$EmployeeProfileModelImpl _$$EmployeeProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeProfileModelImpl(
      id: (json['id'] as num).toInt(),
      branchName: json['branch_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      identificationNumber: json['identification_number'] as String? ?? '',
    );

Map<String, dynamic> _$$EmployeeProfileModelImplToJson(
        _$EmployeeProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_name': instance.branchName,
      'phone': instance.phone,
      'identification_number': instance.identificationNumber,
    };
