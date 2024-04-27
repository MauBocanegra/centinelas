import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class WriteUserIdUseCase implements UseCase<bool, String>{
  const WriteUserIdUseCase({required this.usersRepository});
  final UsersRepository usersRepository;

  @override
  Future<Either<bool, Failure>> call(String uid) async {
    try{
      final wasAbleToWriteUserIdFuture =
        usersRepository.writeLoggedUserInFirestore(uid);
      return wasAbleToWriteUserIdFuture.then(
              (value) => value ? Left(value) : Right(ServerFailure())
      );
    }on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}