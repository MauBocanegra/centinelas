part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}
class NoEmailAppleLoginState extends LoginState {}
class SuccessfulLoginState extends LoginState {
  final String validUserEmail;
  const SuccessfulLoginState({
    required this.validUserEmail
  });
  @override List<Object?> get props => [validUserEmail];
}