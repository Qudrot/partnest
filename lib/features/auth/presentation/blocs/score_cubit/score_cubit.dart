import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partnex/features/auth/presentation/blocs/score_cubit/score_state.dart';
import 'package:partnex/features/auth/data/models/credibility_score.dart';
import 'package:partnex/features/auth/data/repositories/auth_repository.dart';

class ScoreCubit extends Cubit<ScoreState> {
  final AuthRepository authRepository;

  ScoreCubit({required this.authRepository}) : super(ScoreInitial());

  Future<void> fetchDashboardData() async {
    emit(ScoreLoading());
    try {
      final smeProfile = await authRepository.getMySmeProfile();
      final score = await authRepository.getMyScore();
      emit(ScoreLoadedSuccess(score: score, smeProfile: smeProfile));
    } catch (e) {
      emit(ScoreError(message: e.toString()));
    }
  }

  void loadScore(CredibilityScore credibilityScore) {
    // For now we just inject the one we successfully created with an empty profile fallback:
    emit(ScoreLoadedSuccess(score: credibilityScore, smeProfile: {}));
  }
}
