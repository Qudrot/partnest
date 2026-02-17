import 'package:json_annotation/json_annotation.dart';

part 'credibility_score.g.dart';

@JsonSerializable()
class CredibilityScore {
  final String id;
  final String organisationId;
  final double totalScore;
  final double financialHeadlthScore;
  final double transparencyScore;
  final double impactScore;
  final String riskLevel;
  final String explanation;
  final DateTime calculatedAt;

  CredibilityScore({
    required this.id,
    required this.organisationId,
    required this.totalScore,
    required this.financialHeadlthScore,
    required this.transparencyScore,
    required this.impactScore,
    required this.riskLevel,
    required this.explanation,
    required this.calculatedAt,
  });

  factory CredibilityScore.fromJson(Map<String, dynamic> json) => _$CredibilityScoreFromJson(json);
  Map<String, dynamic> toJson() => _$CredibilityScoreToJson(this);

}