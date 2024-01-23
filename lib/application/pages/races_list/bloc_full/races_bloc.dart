import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_collection.dart';
import 'package:centinelas_app/domain/entities/race_ids_collection.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/usecases/load_races_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'races_event.dart';
part 'races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {
  final LoadRacesUseCase loadRacesUseCase;

  RacesBloc({
    required this.loadRacesUseCase,
  }): super (const RacesLoadingState());

  Future<void> readRaces() async {
    emit(const RacesLoadingState());
    try{
      loadRacesUseCase.call(NoParams()).fold(
          (races) => emit(RacesLoadedState(
              racesEntryIdsList: races
          )),
          (failure) => emit(const RacesErrorState())
      );
      /*
      final racesFuture = loadRacesUseCase.call(NoParams());
      final races = await racesFuture;

      if(races.isRight){ // errorState
        debugPrint('races_bloc emits ErrorState from isRight');
        emit(const RacesErrorState());
      } else {
        emit(RacesLoadedState(
            racesEntryIdsList: races.left
        ));
      }
      */
    } on Exception catch(exception){
      debugPrint('races_bloc catches correctly the exception and emits RacesErrorState');
      emit(const RacesErrorState());
    }
  }

}