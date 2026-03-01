import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partnex/features/auth/data/repositories/auth_repository.dart';
import 'discovery_state.dart';
import 'package:flutter/foundation.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  final AuthRepository authRepository;

  DiscoveryCubit({required this.authRepository}) : super(DiscoveryInitial());

  Future<void> loadSmes() async {
    emit(DiscoveryLoading());
    try {
      final dataList = await authRepository.getInvestorSmes();
      
      if (kDebugMode && dataList.isNotEmpty) {
        print('DISCOVERY FEED FIRST ITEM: ${dataList.first}');
      }
      
      // We pass the raw data list to state. We will map it in the UI or a model.
      emit(DiscoveryLoaded(smes: dataList));
    } catch (e) {
      if (kDebugMode) print('DiscoveryCubit Error: $e');
      
      // Clean up Exception prefix if it's there
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.substring(11); // remove 'Exception: '
      }
      
      emit(DiscoveryError('Failed to load SMEs:\n$errorMessage'));
    }
  }
}
