part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable{
  const UsersListState();

  @override
  List<Object> get props => [];
}
class UsersListLoadingState extends UsersListState {}
class UsersListLoadedState extends UsersListState {
  final List<String> usersList;
  const UsersListLoadedState({
    required this.usersList
  });
  @override List<Object> get props => [];
}
class UsersListErrorState extends UsersListState {}