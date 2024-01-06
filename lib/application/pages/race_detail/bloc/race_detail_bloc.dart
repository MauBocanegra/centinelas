import 'dart:async';

import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/usecases/load_race_entry_ids_for_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/unique_id.dart';

part 'race_detail_event.dart';
part 'race_detail_state.dart';

class RaceDetailBloc extends Bloc<RaceDetailEvent, RaceDetailState> {
  RaceDetailBloc({
    required this.collectionId,
    required this.loadRaceEntryIdsForCollection
  }) : super(const RaceDetailLoadingState());

  final CollectionId collectionId;
  final LoadRaceEntryIdsForCollection loadRaceEntryIdsForCollection;

  Future<void> fetch() async{
    emit(const RaceDetailLoadingState());
    try{
      final entryIds = await loadRaceEntryIdsForCollection.call(
          CollectionIdParam(collectionId: collectionId),
      );
      if(entryIds.isRight){
        emit(const RaceDetailErrorState());
      } else {
        emit(RaceDetailLoadedState(
            raceEntryIds: entryIds.left,
            collectionId: collectionId
        ));
      }
    }on Exception {
      emit(const RaceDetailErrorState());
    }
  }
}
