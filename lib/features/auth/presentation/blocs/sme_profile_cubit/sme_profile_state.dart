import 'package:equatable/equatable.dart';

class SmeProfileState extends Equatable {
  // Step 1: Business Profile
  final String businessName;
  final String industry;
  final String location;
  final int yearsOfOperation;
  final int numberOfEmployees;

  // Step 2: Revenue & Expenses
  final double annualRevenue;
  final double annualExpenses;
  final double monthlyAvgRevenue;
  final double monthlyAvgExpenses;

  // Step 3: Liabilities & History
  final double totalLiabilities;
  final double outstandingLoans;
  final bool? hasPriorFunding;
  final double? priorFundingAmount;
  final String? priorFundingSource;
  final int? fundingYear;
  final int? onTimePaymentRate;

  const SmeProfileState({
    this.businessName = '',
    this.industry = '',
    this.location = '',
    this.yearsOfOperation = 0,
    this.numberOfEmployees = 0,
    this.annualRevenue = 0,
    this.annualExpenses = 0,
    this.monthlyAvgRevenue = 0,
    this.monthlyAvgExpenses = 0,
    this.totalLiabilities = 0,
    this.outstandingLoans = 0,
    this.hasPriorFunding,
    this.priorFundingAmount,
    this.priorFundingSource,
    this.fundingYear,
    this.onTimePaymentRate,
  });

  SmeProfileState copyWith({
    String? businessName,
    String? industry,
    String? location,
    int? yearsOfOperation,
    int? numberOfEmployees,
    double? annualRevenue,
    double? annualExpenses,
    double? monthlyAvgRevenue,
    double? monthlyAvgExpenses,
    double? totalLiabilities,
    double? outstandingLoans,
    bool? hasPriorFunding,
    double? priorFundingAmount,
    String? priorFundingSource,
    int? fundingYear,
    int? onTimePaymentRate,
  }) {
    return SmeProfileState(
      businessName: businessName ?? this.businessName,
      industry: industry ?? this.industry,
      location: location ?? this.location,
      yearsOfOperation: yearsOfOperation ?? this.yearsOfOperation,
      numberOfEmployees: numberOfEmployees ?? this.numberOfEmployees,
      annualRevenue: annualRevenue ?? this.annualRevenue,
      annualExpenses: annualExpenses ?? this.annualExpenses,
      monthlyAvgRevenue: monthlyAvgRevenue ?? this.monthlyAvgRevenue,
      monthlyAvgExpenses: monthlyAvgExpenses ?? this.monthlyAvgExpenses,
      totalLiabilities: totalLiabilities ?? this.totalLiabilities,
      outstandingLoans: outstandingLoans ?? this.outstandingLoans,
      hasPriorFunding: hasPriorFunding ?? this.hasPriorFunding,
      priorFundingAmount: priorFundingAmount ?? this.priorFundingAmount,
      priorFundingSource: priorFundingSource ?? this.priorFundingSource,
      fundingYear: fundingYear ?? this.fundingYear,
      onTimePaymentRate: onTimePaymentRate ?? this.onTimePaymentRate,
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
      'annualRevenue': annualRevenue,
      'annualExpenses': annualExpenses,
      'monthlyAvgRevenue': monthlyAvgRevenue,
      'monthlyAvgExpenses': monthlyAvgExpenses,
      'totalLiabilities': totalLiabilities,
      'outstandingLoans': outstandingLoans,
      'hasPriorFunding': hasPriorFunding,
      'priorFundingAmount': priorFundingAmount,
      'priorFundingSource': priorFundingSource,
      'fundingYear': fundingYear,
      'onTimePaymentRate': onTimePaymentRate,
    };
  }

  @override
  List<Object?> get props => [
        businessName,
        industry,
        location,
        yearsOfOperation,
        numberOfEmployees,
        annualRevenue,
        annualExpenses,
        monthlyAvgRevenue,
        monthlyAvgExpenses,
        totalLiabilities,
        outstandingLoans,
        hasPriorFunding,
        priorFundingAmount,
        priorFundingSource,
        fundingYear,
        onTimePaymentRate,
      ];
}
