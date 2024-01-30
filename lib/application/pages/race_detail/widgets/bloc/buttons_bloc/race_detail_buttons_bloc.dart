import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/usecases/write_race_engagement_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'race_detail_buttons_state.dart';
part 'race_detail_buttons_event.dart';

class RaceDetailButtonsBloc extends
Bloc<RaceDetailButtonsEvent, RaceDetailButtonsState>{
  RaceDetailButtonsBloc({
    required this.writeRaceEngagementUseCase
  }): super(RaceDetailButtonsLoadingState());

  final WriteRaceEngagementUseCase writeRaceEngagementUseCase;

  void determineButtonsState(RaceFull raceFull, String uid){
    if(raceFull.raceEngagementState is EmptyEngagementState){
      emit(RaceDetailButtonsOnlyRegisterState(raceFull: raceFull, uid: uid));
    } else if(raceFull.raceEngagementState is RegisteredEngagementState){
      emit(RaceDetailButtonsOnlyCheckInState());
    } else if(raceFull.isRaceActive &&
        raceFull.raceEngagementState is CheckedInEngagementState){
      emit(RaceDetailButtonsOnlyEmergencyState());
    } else {
      emit(RaceDetailButtonsErrorState());
    }
  }

  void registerForRace(String raceId, String uid) async {
    emit(RaceDetailButtonsLoadingState());
    try{
      final wasAbleToRegisterRace =
        await writeRaceEngagementUseCase.call(
          {
            raceIdKeyForMapping : raceId,
            raceEngagementKeyForMapping : RegisterEngagementRequest()
          }
        );
      if(wasAbleToRegisterRace.isLeft){
        /// succesfull
        emit(RaceDetailButtonsOnlyCheckInState());
      } else {
        /// error
        emit(RaceDetailButtonsErrorState());
      }
    }catch(exception){
      emit(RaceDetailButtonsErrorState());
    }
  }

  void checkInRace(String raceId, String uid){
    emit(RaceDetailButtonsLoadingState());
    //TODO process request and show final state
  }

}
