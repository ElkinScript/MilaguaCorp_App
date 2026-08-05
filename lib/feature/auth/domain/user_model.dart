// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,
    @JsonKey(name: 'first_name') @Default('') String firstName,
    @JsonKey(name: 'last_name') @Default('') String lastName,
    @Default('') String email,
    @JsonKey(name: 'full_name') @Default('') String fullName,
    // API returns groups as List<String> (flat names)
    @Default([]) List<String> groups,
    // employee_profile nested object — nullable
    @JsonKey(name: 'employee_profile') @Default(null) EmployeeProfileModel? employeeProfile,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  String get displayName => fullName.isNotEmpty ? fullName : username;
  String get groupName => groups.isNotEmpty ? groups.first : '';
  String get branchName => employeeProfile?.branchName ?? '';

  String get initials {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    }
    final parts = displayName.trim().split(RegExp(r'\s+'))
      ..removeWhere((p) => p.isEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, parts.first.length >= 2 ? 2 : 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

@freezed
class EmployeeProfileModel with _$EmployeeProfileModel {
  const factory EmployeeProfileModel({
    required int id,
    @JsonKey(name: 'branch_name') @Default('') String branchName,
    @Default('') String phone,
    @JsonKey(name: 'identification_number') @Default('') String identificationNumber,
  }) = _EmployeeProfileModel;

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeProfileModelFromJson(json);
}
