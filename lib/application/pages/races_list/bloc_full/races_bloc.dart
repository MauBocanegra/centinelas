import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/usecases/load_races_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    } on Exception catch(exception){
      debugPrint('races_bloc catches correctly '
          'the exception and emits RacesErrorState: ${exception.toString()}');
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      emit(const RacesErrorState());
    }
  }

}