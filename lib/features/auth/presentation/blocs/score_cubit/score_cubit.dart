import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partnex/features/auth/presentation/blocs/score_cubit/score_state.dart';
import 'package:partnex/features/auth/data/models/credibility_score.dart';
import 'package:partnex/features/auth/data/repositories/auth_repository.dart';
import 'package:partnex/features/auth/presentation/blocs/sme_profile_cubit/sme_profile_state.dart';
import 'package:partnex/features/auth/presentation/blocs/sme_profile_cubit/sme_profile_cubit.dart';
import 'package:partnex/core/utils/financial_metrics_calculator.dart';

class ScoreCubit extends Cubit<ScoreState> {
  final AuthRepository authRepository;
  final SmeProfileCubit smeProfileCubit;

  ScoreCubit({required this.authRepository, required this.smeProfileCubit}) : super(ScoreInitial());

  Future<void> fetchDashboardData() async {
    emit(ScoreLoading());
    try {
      final smeProfile = await authRepository.getMySmeProfile();
      final score = await authRepository.getMyScore();
      
      // We don't want to reset the SmeProfileCubit here, as it might
      // hold unsaved local changes or CSV-extracted data.
      // The dashboard will show what's on the server.
      
      final profileState = SmeProfileState.fromMap(smeProfile);
      
      // Sync to SmeProfileCubit so "Add new" has base data
      if (smeProfileCubit.state.businessName.isEmpty) {
        smeProfileCubit.updateFromMap(smeProfile);
      }
      
      final metrics = FinancialMetricsCalculator.calculate(profileState);
      
      emit(ScoreLoadedSuccess(score: score, smeProfile: smeProfile, financialMetrics: metrics));
    } catch (e) {
      emit(ScoreError(message: e.toString()));
    }
  }

  void loadScore(CredibilityScore credibilityScore) {
    final profileState = smeProfileCubit.state;
    final metrics = FinancialMetricsCalculator.calculate(profileState);
    
    emit(ScoreLoadedSuccess(
      score: credibilityScore, 
      smeProfile: profileState.toMap(),
      financialMetrics: metrics
    ));
  }
  
  void reset() {
    emit(ScoreInitial());
  }
}
