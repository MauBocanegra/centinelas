import 'dart:async';

import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/domain/entities/race_entry.dart';
import 'package:centinelas/domain/entities/unique_id.dart';
import 'package:centinelas/domain/usecases/load_race_entry_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
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
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('error at RaceEntryItemProvider: ${exception.toString()}');
      emit(const RaceEntryItemErrorState());
    }
  }
}

