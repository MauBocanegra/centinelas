import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/user_data_model.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class LoadCustomUserDataUseCase implements UseCase<UserDataModel, String>{
  const LoadCustomUserDataUseCase({
    required this.usersRepository,
  });

  final UsersRepository usersRepository;

  @override
  Future<Either<UserDataModel, Failure>> call(String customUserId) async {
    try{
      final userDataResult = usersRepository.readCustomUserData(customUserId);
      return userDataResult.fold(
            (userData) => Left(userData),
            (failure) => Right(failure),
      );
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}