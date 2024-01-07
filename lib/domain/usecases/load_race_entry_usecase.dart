import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';

class LoadRaceEntryUseCase implements UseCase<RaceEntry, RaceEntryIdsParam>{
  const LoadRaceEntryUseCase({required this.raceRepository,});
  final RacesRepository raceRepository;

  @override
  Future<Either<RaceEntry, Failure>> call(RaceEntryIdsParam params) async {
    try {
      final loadedEntry = raceRepository.readRaceEntry(
        params.collectionId,
        params.entryId,
      );

      return loadedEntry.fold(
              (raceEntry) => Left(raceEntry),
              (failure) => Right(failure),
      );
    } on Exception catch(exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }


}