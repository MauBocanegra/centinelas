import 'dart:async';

import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/entities/unique_id.dart';
import '../../../../../../domain/usecases/load_race_entry.dart';

part 'race_entry_item_event.dart';
part 'race_entry_item_state.dart';

class RaceEntryItemBloc extends Bloc<RaceEntryItemEvent, RaceEntryItemState> {
  final RaceEntryId raceEntryId;
  final CollectionId collectionId;
  final LoadRaceEntry loadRaceEntry;

  //final UpdateRaceEntry updateRaceEntry??
  RaceEntryItemBloc({
    required this.loadRaceEntry,
    required this.raceEntryId,
    required this.collectionId,
  }) : super(const RaceEntryItemLoadingState());

  Future<void> fetch() async {
    try {
      final entry = await loadRaceEntry.call(
        RaceEntryIdsParam(
          collectionId: collectionId,
          entryId: raceEntryId,
        ),
      );

      return entry.fold(
            (left) => emit(RaceEntryItemLoadedState(raceEntry: left)),
            (right) => emit(const RaceEntryItemErrorState()),
      );
    } on Exception {
      emit(const RaceEntryItemErrorState());
    }
  }

  Future<void> registerToRace(){
    throw UnimplementedError(
        'race_entry_item_bloc registerToRace not implemented!'
    );
  }

  Future<void> checkinToRace(){
    throw UnimplementedError(
        'race_entry_item_bloc checkinToRace not implemented!'
    );
  }

  Future<void> sendSingleLocation(){
    throw UnimplementedError(
        'race_entry_item_bloc sendSingleLocation not implemented!'
    );
  }
}

