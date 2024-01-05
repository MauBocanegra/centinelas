import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase.dart';
import '../../../../domain/entities/race_collection.dart';
import '../../../../domain/usecases/load_race_collection.dart';

part 'races_list_event.dart';
part 'races_list_state.dart';

class RacesListBloc extends Bloc<RacesListEvent, RacesListState> {

  final LoadRaceCollectionsUseCase loadRaceCollectionsUseCase;

  RacesListBloc({
    required this.loadRaceCollectionsUseCase,
    RacesListState? initialState,
  }): super(initialState ?? const RacesListInitialState());

  Future<void> readRacesCollections() async {
    emit(const RacesListLoadingState());
    try{
      final collectionsFuture = loadRaceCollectionsUseCase.call(NoParams());
      final collections = await collectionsFuture;

      if(collections.isRight){ // errorState
        emit(const RacesListErrorState());
      } else {
        emit(RacesListLoadedState(collections: collections.left));
      }
    } on Exception {
      emit(const RacesListErrorState());
    }
  }

}