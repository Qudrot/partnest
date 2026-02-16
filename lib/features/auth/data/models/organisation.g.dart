// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organisation _$OrganisationFromJson(Map<String, dynamic> json) => Organisation(
  id: json['id'] as String,
  name: json['name'] as String,
  registrationNumber: json['registrationNumber'] as String,
  sector: json['sector'] as String,
  description: json['description'] as String,
  currentCredibilityScore: (json['currentCredibilityScore'] as num?)
      ?.toDouble(),
);

Map<String, dynamic> _$OrganisationToJson(Organisation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registrationNumber': instance.registrationNumber,
      'sector': instance.sector,
      'description': instance.description,
      'currentCredibilityScore': instance.currentCredibilityScore,
    };
