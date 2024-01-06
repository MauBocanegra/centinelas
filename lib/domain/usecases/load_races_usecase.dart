import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_ids_collection.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';

class LoadRacesUseCase implements UseCase<RacesIdsAndRaceCollection, NoParams>{
  const LoadRacesUseCase({required this.racesRepository});
  final RacesRepository racesRepository;

  @override
  Future<Either<RacesIdsAndRaceCollection, Failure>> call(NoParams params) {
    final loadedCollection = racesRepository.readSingleRaceCollection();
    return loadedCollection.fold(
        (collection) {
          final loadedRaceIds = racesRepository.readRaceEntryIds(collection.id);
          return loadedRaceIds.fold(
                (raceIds) => Left(
                    RacesIdsAndRaceCollection(
                      collectionId: collection.id,
                      raceEntryIds: raceIds,
                    )
                ),
                (failure) => Right(failure),
          );
        },
        (failure) {
          return Right(failure);
        }
    );
  }
}