part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override List<Object?> get props => [];
}

class AuthInitialState extends AuthState{
  final bool isLoggedIn;
  final String? userId;
  const AuthInitialState({
    required this.isLoggedIn,
    this.userId
  });

  @override List<Object?> get props => [isLoggedIn, userId];
}