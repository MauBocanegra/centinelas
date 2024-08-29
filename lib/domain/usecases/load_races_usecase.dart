import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/entities/unique_id.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';

class LoadRacesUseCase implements UseCase<List<RaceEntryId>, NoParams>{
  const LoadRacesUseCase({
    required this.racesRepository
  });
  final RacesRepository racesRepository;

  @override
  Future<Either<List<RaceEntryId>, Failure>> call(NoParams params) async {
    try{
      return await racesRepository.readRaceEntryIds().fold(
          (raceEntryIdsList) => Left(raceEntryIdsList),
          (failure) => Right(failure),
      );
    }on Exception catch (exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}