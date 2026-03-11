// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  profilePicture: json['profilePicture'] as String?,
  profileCompleted: json['profileCompleted'] as bool? ?? false,
  position: json['position'] as String?,
  investorType: json['investorType'] as String?,
  company: json['company'] as String?,
  investmentRange: json['investmentRange'] as String?,
  sectors: (json['sectors'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'role': _$UserRoleEnumMap[instance.role]!,
  'profilePicture': instance.profilePicture,
  'profileCompleted': instance.profileCompleted,
  'position': instance.position,
  'investorType': instance.investorType,
  'company': instance.company,
  'investmentRange': instance.investmentRange,
  'sectors': instance.sectors,
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.sme: 'sme',
  UserRole.investor: 'investor',
};
