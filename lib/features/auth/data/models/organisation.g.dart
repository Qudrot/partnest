// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organisation _$OrganisationFromJson(Map<String, dynamic> json) => Organisation(
  id: json['id'] as String,
  businessName: json['businessName'] as String,
  registrationNumber: json['registrationNumber'] as String,
  industry: json['industry'] as String,
  description: json['description'] as String,
  location: json['location'] as String,
  yearsOfOperation: (json['yearsOfOperation'] as num).toInt(),
  numbersOfEmployee: (json['numbersOfEmployee'] as num).toInt(),
  annualRevenue: (json['annualRevenue'] as num).toDouble(),
  monthlyExpenses: (json['monthlyExpenses'] as num).toDouble(),
  priorFundingHistory: json['priorFundingHistory'] as String?,
  repaymentHistory: json['repaymentHistory'] as String?,
  currentCredibilityScore: (json['currentCredibilityScore'] as num?)
      ?.toDouble(),
  monthlyRevenue: (json['monthlyRevenue'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OrganisationToJson(Organisation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessName': instance.businessName,
      'registrationNumber': instance.registrationNumber,
      'industry': instance.industry,
      'description': instance.description,
      'location': instance.location,
      'yearsOfOperation': instance.yearsOfOperation,
      'numbersOfEmployee': instance.numbersOfEmployee,
      'annualRevenue': instance.annualRevenue,
      'monthlyExpenses': instance.monthlyExpenses,
      'priorFundingHistory': instance.priorFundingHistory,
      'repaymentHistory': instance.repaymentHistory,
      'currentCredibilityScore': instance.currentCredibilityScore,
      'monthlyRevenue': instance.monthlyRevenue,
    };
