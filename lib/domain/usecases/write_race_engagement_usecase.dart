import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/src/either.dart';

class WriteRaceEngagementUseCase implements UseCase<bool, Map<String, dynamic>>{
  const WriteRaceEngagementUseCase({required this.usersRepository});
  final UsersRepository usersRepository;

  @override
  Future<Either<bool, Failure>> call(Map<String, dynamic> params) async {
    try{
      final wasAbleToWriteRaceEngagement =
          usersRepository.writeRaceEngagementInFirestore(
              params[raceIdKeyForMapping],
              params[raceEngagementKeyForMapping],
          );
      return wasAbleToWriteRaceEngagement.then(
              (value) => value ? Left(value) : Right(ServerFailure())
      );
    }on Exception catch(exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}