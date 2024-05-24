import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class LoadUsersListUseCase implements UseCase<List<String>, NoParams>{
  const LoadUsersListUseCase({
    required this.usersRepository,
  });
  final UsersRepository usersRepository;

  @override
  Future<Either<List<String>, Failure>> call(NoParams params) async {
    try{
      final usersListResult = usersRepository.readUsersList();
      return usersListResult.fold(
          (usersList) => Left(usersList),
          (failure) => Right(failure),
      );
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }

}