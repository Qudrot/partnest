import 'package:json_annotation/json_annotation.dart';

part 'organisation.g.dart';

@JsonSerializable()
class Organisation {
  final String id;
  final String businessName;
  final String registrationNumber;
  final String industry;
  final String description;
  final String location;
  final int yearsOfOperation;
  final int numbersOfEmployee;
  final double annualRevenue;
  final double monthlyExpenses;
  final String? priorFundingHistory;
  final String? repaymentHistory;
  final double? currentCredibilityScore;
  final double? monthlyRevenue;

  Organisation({
    required this.id,
    required this.businessName,
    required this.registrationNumber,
    required this.industry,
    required this.description,
    required this.location,
    required this.yearsOfOperation,
    required this.numbersOfEmployee,
    required this.annualRevenue,
    required this.monthlyExpenses,
    this.priorFundingHistory,
    this.repaymentHistory,
    this.currentCredibilityScore,
    this.monthlyRevenue,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);
  Map<String, dynamic> toJson() => _$OrganisationToJson(this);

}