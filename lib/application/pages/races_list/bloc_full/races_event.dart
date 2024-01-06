part of 'races_bloc.dart';

@immutable
abstract class RacesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RacesRequestedEvent extends RacesEvent {}