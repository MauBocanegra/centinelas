part of 'race_detail_buttons_bloc.dart';

abstract class RaceDetailButtonsState extends Equatable{
  const RaceDetailButtonsState();
  @override List<Object?> get props => [];
}
class RaceDetailButtonsLoadingState extends RaceDetailButtonsState{}
class RaceDetailButtonsOnlyRegisterState extends RaceDetailButtonsState {}
class RaceDetailButtonsOnlyCheckInState extends RaceDetailButtonsState {}
class RaceDetailButtonsCheckedInNotActiveState extends RaceDetailButtonsState {}
class RaceDetailButtonsIncidenceState extends RaceDetailButtonsState {}
class RaceDetailButtonsIncidenceWithSuccessState extends RaceDetailButtonsState {}
class RaceDetailButtonsIncidenceWithErrorState extends RaceDetailButtonsState {}
class RaceDetailButtonsErrorState extends RaceDetailButtonsState {}
class RaceDetailButtonsPhoneUpdateState extends RaceDetailButtonsState {}