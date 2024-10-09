import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class TryAppleLoginUseCase implements UseCase<String, NoParams>{

  const TryAppleLoginUseCase({
    required this.usersRepository,
  });
  final UsersRepository usersRepository;

  @override
  Future<Either<String, Failure>> call(NoParams params) async {
    try{
      final appleLoginResult = await usersRepository.getEmailFromAppleLogin();
      return appleLoginResult.fold(
          (validUserEmail) => Left(validUserEmail),
          (failure) => Right(failure),
      );
    } on Exception catch(exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: "$exception [UseCase]"));
    }
  }

}