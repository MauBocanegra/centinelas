part of 'race_detail_bloc.dart';

abstract class RaceDetailState extends Equatable {
  const RaceDetailState();
  @override List<Object?> get props => [];
}

class RaceDetailLoadingState extends RaceDetailState {
  const RaceDetailLoadingState();
}
class RaceDetailErrorState extends RaceDetailState {
  const RaceDetailErrorState();
}
class RaceDetailLoadedState extends RaceDetailState {
  const RaceDetailLoadedState({
    required this.raceFull
  });
  final RaceFull raceFull;
  @override List<Object?> get props => [raceFull];
}
