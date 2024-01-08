import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationCubitState>{
  NavigationCubit(): super(const NavigationCubitState());

  void selectedRaceChanged(RaceEntryId raceEntryId){
    emit(NavigationCubitState(selectedRaceId: raceEntryId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    if (state.isSecondBodyDisplayed != isSecondBodyDisplayed) {
      emit(NavigationCubitState(
        isSecondBodyDisplayed: isSecondBodyDisplayed,
        selectedCollectionId: state.selectedCollectionId,
      ));
    }
  }
}