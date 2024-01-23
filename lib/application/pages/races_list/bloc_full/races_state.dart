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
  final List<RaceEntryId> racesEntryIdsList;
  const RacesLoadedState({required this.racesEntryIdsList});
  @override List<Object?> get props => [racesEntryIdsList];
}