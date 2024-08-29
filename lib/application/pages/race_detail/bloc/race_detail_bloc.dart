import 'dart:async';

import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/domain/entities/race_full.dart';
import 'package:centinelas/domain/entities/unique_id.dart';
import 'package:centinelas/domain/usecases/load_race_full_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'race_detail_event.dart';
part 'race_detail_state.dart';

class RaceDetailBloc extends Bloc<RaceDetailEvent, RaceDetailState> {
  RaceDetailBloc({
    required this.loadRaceFullUseCase,
  }) : super(const RaceDetailLoadingState());

  final LoadRaceFullUseCase loadRaceFullUseCase;

  Future<void> readRaceFull(RaceEntryId raceEntryId) async{
    emit(const RaceDetailLoadingState());
    try{
      final raceFull = await loadRaceFullUseCase.call(raceEntryId);
      if(raceFull.isRight){
        emit(const RaceDetailErrorState());
      } else {
        emit(RaceDetailLoadedState(raceFull: raceFull.left));
      }
    }catch(exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint(exception.toString());
      emit(const RaceDetailErrorState());
    }
  }
}
