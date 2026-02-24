import 'package:equatable/equatable.dart';

class SmeProfileState extends Equatable {
  // Step 1: Business Profile
  final String businessName;
  final String industry;
  final String location;
  final int yearsOfOperation;
  final int numberOfEmployees;

  // Step 2: Revenue & Expenses
  final double year1Revenue;
  final double year2Revenue;
  final double? year3Revenue;
  final double monthlyAvgRevenue;
  final double monthlyAvgExpenses;

  // Step 3: Liabilities & History
  final double existingLiabilities;
  final String? liabilityType;
  final bool? hasPriorFunding;
  final double? priorFundingAmount;
  final String? priorFundingSource;
  final int? fundingYear;
  final bool? hasDefaulted;
  final String? defaultDetails;
  final String? paymentTimeliness;

  const SmeProfileState({
    this.businessName = '',
    this.industry = '',
    this.location = '',
    this.yearsOfOperation = 0,
    this.numberOfEmployees = 0,
    this.year1Revenue = 0,
    this.year2Revenue = 0,
    this.year3Revenue,
    this.monthlyAvgRevenue = 0,
    this.monthlyAvgExpenses = 0,
    this.existingLiabilities = 0,
    this.liabilityType,
    this.hasPriorFunding,
    this.priorFundingAmount,
    this.priorFundingSource,
    this.fundingYear,
    this.hasDefaulted,
    this.defaultDetails,
    this.paymentTimeliness,
  });

  SmeProfileState copyWith({
    String? businessName,
    String? industry,
    String? location,
    int? yearsOfOperation,
    int? numberOfEmployees,
    double? year1Revenue,
    double? year2Revenue,
    double? year3Revenue,
    double? monthlyAvgRevenue,
    double? monthlyAvgExpenses,
    double? existingLiabilities,
    String? liabilityType,
    bool? hasPriorFunding,
    double? priorFundingAmount,
    String? priorFundingSource,
    int? fundingYear,
    bool? hasDefaulted,
    String? defaultDetails,
    String? paymentTimeliness,
  }) {
    return SmeProfileState(
      businessName: businessName ?? this.businessName,
      industry: industry ?? this.industry,
      location: location ?? this.location,
      yearsOfOperation: yearsOfOperation ?? this.yearsOfOperation,
      numberOfEmployees: numberOfEmployees ?? this.numberOfEmployees,
      year1Revenue: year1Revenue ?? this.year1Revenue,
      year2Revenue: year2Revenue ?? this.year2Revenue,
      year3Revenue: year3Revenue ?? this.year3Revenue,
      monthlyAvgRevenue: monthlyAvgRevenue ?? this.monthlyAvgRevenue,
      monthlyAvgExpenses: monthlyAvgExpenses ?? this.monthlyAvgExpenses,
      existingLiabilities: existingLiabilities ?? this.existingLiabilities,
      liabilityType: liabilityType ?? this.liabilityType,
      hasPriorFunding: hasPriorFunding ?? this.hasPriorFunding,
      priorFundingAmount: priorFundingAmount ?? this.priorFundingAmount,
      priorFundingSource: priorFundingSource ?? this.priorFundingSource,
      fundingYear: fundingYear ?? this.fundingYear,
      hasDefaulted: hasDefaulted ?? this.hasDefaulted,
      defaultDetails: defaultDetails ?? this.defaultDetails,
      paymentTimeliness: paymentTimeliness ?? this.paymentTimeliness,
    );
  }

  // Helper method to gather data into a map for submission
  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'industry': industry,
      'location': location,
      'yearsOfOperation': yearsOfOperation,
      'numberOfEmployees': numberOfEmployees,
      'year1Revenue': year1Revenue,
      'year2Revenue': year2Revenue,
      'year3Revenue': year3Revenue,
      'monthlyAvgRevenue': monthlyAvgRevenue,
      'monthlyAvgExpenses': monthlyAvgExpenses,
      'existingLiabilities': existingLiabilities,
      'liabilityType': liabilityType,
      'hasPriorFunding': hasPriorFunding,
      'priorFundingAmount': priorFundingAmount,
      'priorFundingSource': priorFundingSource,
      'fundingYear': fundingYear,
      'hasDefaulted': hasDefaulted,
      'defaultDetails': defaultDetails,
      'paymentTimeliness': paymentTimeliness,
    };
  }

  @override
  List<Object?> get props => [
        businessName,
        industry,
        location,
        yearsOfOperation,
        numberOfEmployees,
        year1Revenue,
        year2Revenue,
        year3Revenue,
        monthlyAvgRevenue,
        monthlyAvgExpenses,
        existingLiabilities,
        liabilityType,
        hasPriorFunding,
        priorFundingAmount,
        priorFundingSource,
        fundingYear,
        hasDefaulted,
        defaultDetails,
        paymentTimeliness,
      ];
}
