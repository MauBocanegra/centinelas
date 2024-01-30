part of 'race_detail_buttons_bloc.dart';

abstract class RaceDetailButtonsState extends Equatable{
  const RaceDetailButtonsState();
}
class RaceDetailButtonsLoadingState extends RaceDetailButtonsState{
  @override List<Object?> get props => [];
}
class RaceDetailButtonsOnlyRegisterState extends RaceDetailButtonsState {
  const RaceDetailButtonsOnlyRegisterState({
    required this.raceFull,
    required this.uid,
  });
  final RaceFull raceFull;
  final String uid;
  @override List<Object?> get props => [raceFull, uid];
}
class RaceDetailButtonsOnlyCheckInState extends RaceDetailButtonsState {
  @override List<Object?> get props => [];
}
class RaceDetailButtonsOnlyEmergencyState extends RaceDetailButtonsState {
  @override List<Object?> get props => [];
}

class RaceDetailButtonsErrorState extends RaceDetailButtonsState {
  @override List<Object?> get props => [];
}