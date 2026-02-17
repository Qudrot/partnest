// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credibility_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredibilityScore _$CredibilityScoreFromJson(Map<String, dynamic> json) =>
    CredibilityScore(
      id: json['id'] as String,
      organisationId: json['organisationId'] as String,
      totalScore: (json['totalScore'] as num).toDouble(),
      financialHeadlthScore: (json['financialHeadlthScore'] as num).toDouble(),
      transparencyScore: (json['transparencyScore'] as num).toDouble(),
      impactScore: (json['impactScore'] as num).toDouble(),
      riskLevel: json['riskLevel'] as String,
      explanation: json['explanation'] as String,
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );

Map<String, dynamic> _$CredibilityScoreToJson(CredibilityScore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organisationId': instance.organisationId,
      'totalScore': instance.totalScore,
      'financialHeadlthScore': instance.financialHeadlthScore,
      'transparencyScore': instance.transparencyScore,
      'impactScore': instance.impactScore,
      'riskLevel': instance.riskLevel,
      'explanation': instance.explanation,
      'calculatedAt': instance.calculatedAt.toIso8601String(),
    };
