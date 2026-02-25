import 'package:flutter_bloc/flutter_bloc.dart';
import 'sme_profile_state.dart';

class SmeProfileCubit extends Cubit<SmeProfileState> {
  SmeProfileCubit() : super(const SmeProfileState());

  void updateBusinessProfile({
    required String businessName,
    required String industry,
    required String location,
    required int yearsOfOperation,
    required int numberOfEmployees,
  }) {
    emit(state.copyWith(
      businessName: businessName,
      industry: industry,
      location: location,
      yearsOfOperation: yearsOfOperation,
      numberOfEmployees: numberOfEmployees,
    ));
  }

  void updateRevenueExpenses({
    required double annualRevenue,
    required double annualExpenses,
    required double monthlyAvgRevenue,
    required double monthlyAvgExpenses,
  }) {
    emit(state.copyWith(
      annualRevenue: annualRevenue,
      annualExpenses: annualExpenses,
      monthlyAvgRevenue: monthlyAvgRevenue,
      monthlyAvgExpenses: monthlyAvgExpenses,
    ));
  }

  void updateLiabilitiesHistory({
    required double totalLiabilities,
    required double outstandingLoans,
    bool? hasPriorFunding,
    double? priorFundingAmount,
    String? priorFundingSource,
    int? fundingYear,
    int? onTimePaymentRate,
  }) {
    emit(state.copyWith(
      totalLiabilities: totalLiabilities,
      outstandingLoans: outstandingLoans,
      hasPriorFunding: hasPriorFunding,
      priorFundingAmount: priorFundingAmount,
      priorFundingSource: priorFundingSource,
      fundingYear: fundingYear,
      onTimePaymentRate: onTimePaymentRate,
    ));
  }
}
