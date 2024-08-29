import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class WriteUserIdUseCase implements UseCase<bool, NoParams>{
  const WriteUserIdUseCase({required this.usersRepository});
  final UsersRepository usersRepository;

  @override
  Future<Either<bool, Failure>> call(NoParams params) async {
    try{
      final wasAbleToWriteUserIdFuture =
        usersRepository.writeLoggedUserInFirestore();
      return wasAbleToWriteUserIdFuture.then(
              (value) => value ? Left(value) : Right(ServerFailure())
      );
    }on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}