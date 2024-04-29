import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/data/sealed_classes/checkin_race_attempt_resolution.dart';
import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/usecases/write_incidence_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_phone_write_checkin_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_race_checkin_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_race_engagement_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'race_detail_buttons_state.dart';
part 'race_detail_buttons_event.dart';

class RaceDetailButtonsBloc extends
Bloc<RaceDetailButtonsEvent, RaceDetailButtonsState>{
  RaceDetailButtonsBloc({
    required this.writeRaceEngagementUseCase,
    required this.writeRaceCheckinUseCase,
    required this.writePhoneWriteCheckInUseCase,
    required this.writeIncidenceUseCase,
  }): super(RaceDetailButtonsLoadingState());

  final WriteRaceEngagementUseCase writeRaceEngagementUseCase;
  final WriteRaceCheckinUseCase writeRaceCheckinUseCase;
  final WritePhoneWriteCheckInUseCase writePhoneWriteCheckInUseCase;
  final WriteIncidenceUseCase writeIncidenceUseCase;

  void determineButtonsState(RaceFull raceFull){
    if(raceFull.raceEngagementState is EmptyEngagementState){
      emit(RaceDetailButtonsOnlyRegisterState());
    } else if(raceFull.raceEngagementState is RegisteredEngagementState){
      emit(RaceDetailButtonsOnlyCheckInState());
    } else if(!raceFull.isRaceActive &&
        raceFull.raceEngagementState is CheckedInEngagementState){
      emit(RaceDetailButtonsCheckedInNotActiveState());
    } else if(raceFull.isRaceActive &&
        raceFull.raceEngagementState is CheckedInEngagementState){
      emit(RaceDetailButtonsIncidenceState());
    }else {
      emit(RaceDetailButtonsErrorState());
    }
  }

  void registerForRace(RaceFull raceFull) async {
    emit(RaceDetailButtonsLoadingState());
    try{
      final wasAbleToRegisterRace =
        await writeRaceEngagementUseCase.call(
          {
            raceIdKeyForMapping : raceFull.id.value,
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

  void checkInRace(RaceFull raceFull) async {
    emit(RaceDetailButtonsLoadingState());

    try{
      final checkInState =
        await writeRaceCheckinUseCase.call(raceFull.id.value);
      if(checkInState.isLeft){
        if (checkInState.left is NeedsPhoneUpdateCheckInRaceAttemptResolution){
          emit(RaceDetailButtonsPhoneUpdateState());
        } else if(checkInState.left is SuccessfulCheckInRaceAttemptResolution){
          if(raceFull.isRaceActive){
            emit(RaceDetailButtonsIncidenceState());
          } else {
            emit(RaceDetailButtonsCheckedInNotActiveState());
          }
        }
      }else{
        emit(RaceDetailButtonsErrorState());
      }
    }catch(exception){
      emit(RaceDetailButtonsErrorState());
    }
  }

  /// todo remove uid from params, this is leakage
  void updatePhoneThenCheckIn(RaceFull raceFull, String phone) async {
    emit(RaceDetailButtonsLoadingState());

    try{
      final writePhoneWriteCheckInResult =
        await writePhoneWriteCheckInUseCase.call(
          {
            raceIdKeyForMapping : raceFull.id.value,
            phoneKeyForMapping: phone,
            raceEngagementKeyForMapping : CheckInEngagementRequest()
          }
        );
      writePhoneWriteCheckInResult.fold(
        (checkinRaceAttemptResolution){
          if(checkinRaceAttemptResolution is
            SuccessfulCheckInRaceAttemptResolution){
              if(raceFull.isRaceActive){
                emit(RaceDetailButtonsIncidenceState());
              } else {
                emit(RaceDetailButtonsCheckedInNotActiveState());
              }
            } else {
              throw Exception('Unable to complete writeRaceCheckIn');
            }
        },
        (right) => emit(RaceDetailButtonsErrorState())
      );

    }catch(exception){
      emit(RaceDetailButtonsErrorState());
    }
  }

  void writeIncidence(Map<String, dynamic> params) async {
    emit(RaceDetailButtonsLoadingState());
    try{
      final writeIncidenceResult = await writeIncidenceUseCase.call(params);
      writeIncidenceResult.fold(
          (wasAbleToWriteIncidence){
            if(wasAbleToWriteIncidence){
              emit(RaceDetailButtonsIncidenceWithSuccessState());
            } else {
              emit(RaceDetailButtonsIncidenceWithErrorState());
            }
          },
          (right) => emit(RaceDetailButtonsIncidenceState())
      );
    }catch(exception){
      /// should an extra layer of error display be added?
      emit(RaceDetailButtonsIncidenceState());
    }
  }

}
