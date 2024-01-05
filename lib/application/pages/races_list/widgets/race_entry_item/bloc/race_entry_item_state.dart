part of 'race_entry_item_bloc.dart';

abstract class RaceEntryItemState extends Equatable {
  const RaceEntryItemState();

  @override
  List<Object> get props => [];
}

class RaceEntryItemInitialState extends RaceEntryItemState {
  const RaceEntryItemInitialState();
}
class RaceEntryItemLoadingState extends RaceEntryItemState {
  const RaceEntryItemLoadingState();
}
class RaceEntryItemErrorState extends RaceEntryItemState {
  const RaceEntryItemErrorState();
}
class RaceEntryItemLoadedState extends RaceEntryItemState {
  const RaceEntryItemLoadedState({
    required this.raceEntry
  });
  final RaceEntry raceEntry;

  @override
  List<Object> get props => [raceEntry];
}