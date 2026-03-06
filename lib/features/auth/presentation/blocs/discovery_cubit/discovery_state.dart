import 'package:equatable/equatable.dart';
import 'package:partnex/features/auth/data/models/sme_profile_data.dart';

abstract class DiscoveryState extends Equatable {
  const DiscoveryState();

  @override
  List<Object?> get props => [];
}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {}

class DiscoveryLoaded extends DiscoveryState {
  final List<SmeCardData> smes;

  DiscoveryLoaded({required List<SmeCardData> smes})
      // Explicit cast ensures JS runtime knows the exact element type
      : smes = List<SmeCardData>.from(smes);

  @override
  List<Object?> get props => [smes];
}

class DiscoveryError extends DiscoveryState {
  final String message;

  const DiscoveryError(this.message);

  @override
  List<Object?> get props => [message];
}
