import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_collection.dart';
import 'package:centinelas_app/domain/entities/race_ids_collection.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/usecases/load_races_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'races_event.dart';
part 'races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {
  final LoadRacesUseCase loadRacesUseCase;

  RacesBloc({
    required this.loadRacesUseCase,
    RacesState? loadingState,
  }): super (loadingState ?? const RacesLoadingState());

  Future<void> readRaces() async {
    emit(const RacesLoadingState());
    try{
      final racesFuture = loadRacesUseCase.call(NoParams());
      final races = await racesFuture;

      if(races.isRight){ // errorState
        emit(const RacesErrorState());
      } else {
        emit(RacesLoadedState(
            racesIdsAndRaceCollection: races.left
        ));
      }
    } on Exception {
      emit(const RacesErrorState());
    }
  }

}