part of 'races_list_bloc.dart';

@immutable
abstract class RacesListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RacesListRequestedEvent extends RacesListEvent {}