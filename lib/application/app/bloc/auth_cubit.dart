import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit() : super(
      const AuthInitialState(isLoggedIn: false)
  );

  void authStateChanged({User? user}) {
    final bool isLoggedIn = user != null;
    emit(AuthInitialState(
        userId: user?.uid,
        isLoggedIn: isLoggedIn
    ));
  }
}