import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/usecases/try_apple_login_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc({
    required this.tryAppleLoginUseCase,
  }) : super(LoginInitialState());
  final TryAppleLoginUseCase tryAppleLoginUseCase;

  Future<void> tryAppleLogin() async {
    try{
      await tryAppleLoginUseCase.call(NoParams()).fold(
            (emailFromApple) => emit(SuccessfulLoginState(validUserEmail: emailFromApple)),
            (failure) => emit(NoEmailAppleLoginState()),
      );
    } on Exception catch (exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('errorOnLoadingProfile ${exception.toString()}');
    }
  }

}