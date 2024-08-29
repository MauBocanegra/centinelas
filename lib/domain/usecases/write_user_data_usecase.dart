import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/entities/user_data_model.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';

class WriteUserDataUseCase implements
  UseCase<bool, UserDataModel>{

  const WriteUserDataUseCase({
    required this.usersRepository
  });
  final UsersRepository usersRepository;

  @override
  Future<Either<bool, Failure>> call(UserDataModel param) async {
    final wasAbleToUpdateData =
      await usersRepository.updateUserData(param);

    if(wasAbleToUpdateData){
      return const Left(true);
    } else {
      return Right(ServerFailure());
    }
  }

}