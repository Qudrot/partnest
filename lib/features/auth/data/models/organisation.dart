import 'package:json_annotation/json_annotation.dart';

part 'organisation.g.dart';

@JsonSerializable()
class Organisation {
  final String id;
  final String name;
  final String registrationNumber;
  final String sector;
  final String description;
  final String? priorFundingHistory;
  final String? repaymentHistory;
  final double? currentCredibilityScore;
  final double? monthlyRevenue;

  Organisation({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.sector,
    required this.description,
    this.priorFundingHistory,
    this.repaymentHistory,
    this.currentCredibilityScore,
    this.monthlyRevenue,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  Map<String, dynamic> toJson() => _$OrganisationToJson(this);

}