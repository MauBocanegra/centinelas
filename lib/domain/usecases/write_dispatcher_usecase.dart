import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class WriteDispatcherUseCase implements UseCase<String, NoParams>{

  const WriteDispatcherUseCase({
    required this.usersRepository,
  });
  final UsersRepository usersRepository;

  @override
  Future<Either<String, Failure>> call(NoParams params) async {
    try{
      final String userEmail = serviceLocator<FirebaseAuth>().currentUser?.email ?? '';
      final String userId = serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';
      throw UnimplementedError();
    } on Exception catch(exception){
      debugPrint('Exception WriteFCMTokenUseCase: ${exception.toString()}');
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }

}