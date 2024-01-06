part of 'races_bloc.dart';

@immutable
abstract class RacesState extends Equatable {
  const RacesState();
  @override List<Object?> get props => [];
}

class RacesLoadingState extends RacesState {
  const RacesLoadingState();
}
class RacesErrorState extends RacesState {
  const RacesErrorState();
}
class RacesLoadedState extends RacesState {
  const RacesLoadedState({required this.racesIdsAndRaceCollection});
  final RacesIdsAndRaceCollection racesIdsAndRaceCollection;
  @override List<Object?> get props => [racesIdsAndRaceCollection];
}