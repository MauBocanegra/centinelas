import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/domain/entities/user_data_model.dart';
import 'package:centinelas_app/domain/usecases/load_custom_user_data_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_user_data_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileBloc({
    required this.loadCustomUserDataUseCase,
    required this.writeUserDataUseCase,
  }) : super(ProfileLoadingState());

  final LoadCustomUserDataUseCase loadCustomUserDataUseCase;
  final WriteUserDataUseCase writeUserDataUseCase;

  Future<void> loadUserData() async {
    emit(ProfileLoadingState());
    try{
      // leaking data?
      final userDataResponse = await loadCustomUserDataUseCase.call(
          serviceLocator<FirebaseAuth>().currentUser?.uid ?? ''
      ).fold(
          (userData) => emit(ProfileLoadedState(userDataModel: userData)),
          (failure) => emit(ProfileErrorState()),
      );
    } on Exception catch(exception){
      debugPrint('errorOnLoadingProfile ${exception.toString()}');
      emit(ProfileErrorState());
    }
  }

  Future<void> updateUserData(UserDataModel userDataModel) async {
    debugPrint('will start updating userDataModel...');
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('updating userDataModel...');
    try{
        await writeUserDataUseCase.call(userDataModel).fold(
                (left) => emit(ProfileLoadedState(userDataModel: userDataModel)),
                (right) => ProfileErrorState()
        );
    } on Exception catch(exception) {
      debugPrint('error updatingUserData[ProfileBloc] ${exception.toString()}');
    }
  }
}