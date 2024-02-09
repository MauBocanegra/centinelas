part of 'dispatch_bloc.dart';

abstract class DispatchState extends Equatable {
  const DispatchState();
  @override List<Object?> get props => [];
}

class DispatchLoadingState extends DispatchState {
  const DispatchLoadingState();
}
class DispatchErrorState extends DispatchState {
  const DispatchErrorState();
}
class DispatchLoadedState extends DispatchState {
  const DispatchLoadedState();
}