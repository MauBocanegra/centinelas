part of 'races_list_bloc.dart';

@immutable
abstract class RacesListState extends Equatable {
  const RacesListState();
  @override List<Object?> get props => [];
}

class RacesListInitialState extends RacesListState {
  const RacesListInitialState();
}
class RacesListLoadingState extends RacesListState {
  const RacesListLoadingState();
}
class RacesListErrorState extends RacesListState {
  const RacesListErrorState();
}
class RacesListLoadedState extends RacesListState {
  const RacesListLoadedState({required this.collections});
  final List<RaceCollection> collections;
  @override List<Object?> get props => [collections];
}