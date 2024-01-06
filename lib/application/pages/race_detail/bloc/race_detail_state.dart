part of 'race_detail_bloc.dart';

abstract class RaceDetailState extends Equatable {
  const RaceDetailState();
  @override List<Object?> get props => [];
}

class RaceDetailInitialState extends RaceDetailState {
  const RaceDetailInitialState();
}
class RaceDetailLoadingState extends RaceDetailState {
  const RaceDetailLoadingState();
}
class RaceDetailErrorState extends RaceDetailState {
  const RaceDetailErrorState();
}
class RaceDetailLoadedState extends RaceDetailState {
  const RaceDetailLoadedState({
    required this.raceEntryIds,
    required this.collectionId,
  });
  final List<RaceEntryId> raceEntryIds;
  final CollectionId collectionId;
  @override List<Object?> get props => [raceEntryIds, collectionId];
}

