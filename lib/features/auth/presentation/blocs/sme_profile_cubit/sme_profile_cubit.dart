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
    required double year1Revenue,
    required double year2Revenue,
    double? year3Revenue,
    required double monthlyAvgRevenue,
    required double monthlyAvgExpenses,
  }) {
    emit(state.copyWith(
      year1Revenue: year1Revenue,
      year2Revenue: year2Revenue,
      year3Revenue: year3Revenue,
      monthlyAvgRevenue: monthlyAvgRevenue,
      monthlyAvgExpenses: monthlyAvgExpenses,
    ));
  }

  void updateLiabilitiesHistory({
    required double existingLiabilities,
    String? liabilityType,
    bool? hasPriorFunding,
    double? priorFundingAmount,
    String? priorFundingSource,
    int? fundingYear,
    bool? hasDefaulted,
    String? defaultDetails,
    String? paymentTimeliness,
  }) {
    emit(state.copyWith(
      existingLiabilities: existingLiabilities,
      liabilityType: liabilityType,
      hasPriorFunding: hasPriorFunding,
      priorFundingAmount: priorFundingAmount,
      priorFundingSource: priorFundingSource,
      fundingYear: fundingYear,
      hasDefaulted: hasDefaulted,
      defaultDetails: defaultDetails,
      paymentTimeliness: paymentTimeliness,
    ));
  }
}
