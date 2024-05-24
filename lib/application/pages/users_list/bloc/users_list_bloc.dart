import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/usecases/load_users_list_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_list_state.dart';
part 'users_list_event.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState>{
  UsersListBloc({
    required this.loadUsersListUseCase,
  }) : super(UsersListLoadingState());

  final LoadUsersListUseCase loadUsersListUseCase;

  Future<void> loadUsersList() async {
    try {
      await loadUsersListUseCase.call(NoParams()).fold(
          (usersList) => emit(UsersListLoadedState(
              usersList: usersList
          )),
          (failure) => emit(UsersListErrorState()),
      );
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('errorOnUsersListUseCase ${exception.toString()}');
      emit(UsersListErrorState());
    }
  }
}