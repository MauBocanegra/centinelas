import 'dart:async';

import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/usecases/load_race_entry_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'race_entry_item_event.dart';
part 'race_entry_item_state.dart';

class RaceEntryItemBloc extends Bloc<RaceEntryItemEvent, RaceEntryItemState> {
  final LoadRaceEntryUseCase loadRaceEntryUseCase;

  //final UpdateRaceEntry updateRaceEntry??
  RaceEntryItemBloc({
    required this.loadRaceEntryUseCase,
  }) : super(const RaceEntryItemLoadingState());

  Future<void> readRaceEntryItem(
    RaceEntryId raceEntryId,
  ) async {
    try {
      final entry = await loadRaceEntryUseCase.call(
        raceEntryId
      );

      return entry.fold(
            (left) => emit(RaceEntryItemLoadedState(
                raceEntry: left,
            )),
            (right) => emit(const RaceEntryItemErrorState()),
      );
    } on Exception {
      emit(const RaceEntryItemErrorState());
    }
  }
}

