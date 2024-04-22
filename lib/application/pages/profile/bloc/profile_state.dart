part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable{
  const ProfileState();
  @override List<Object?> get props => [];
}
class ProfileLoadingState extends ProfileState {}
class ProfileLoadedState extends ProfileState {
  final UserDataModel userDataModel;
  const ProfileLoadedState({
    required this.userDataModel
  });
  @override List<Object?> get props => [userDataModel];
}
class ProfileErrorState extends ProfileState {}
class ProfileSavePendingState extends ProfileState {}