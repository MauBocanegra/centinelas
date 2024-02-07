import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/realtime_repository.dart';
import 'package:either_dart/src/either.dart';

class WriteIncidenceUseCase implements UseCase<bool, Map<String, dynamic>>{
  const WriteIncidenceUseCase({required this.realtimeRepository});
  final RealtimeRepository realtimeRepository;

  @override
  Future<Either<bool, Failure>> call(Map<String, dynamic> params) async {
    try{
      final wasAbleToWriteIncidence =
        realtimeRepository.writeIncidenceInRealtimeDB(params);
      return wasAbleToWriteIncidence.then(
        (value) => value ? Left(value) : Right(ServerFailure())
      );
    } on Exception catch(exception){
    return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}