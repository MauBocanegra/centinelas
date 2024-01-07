import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';

class LoadRaceEntryIdsForCollectionUseCase implements UseCase<List<RaceEntryId>, CollectionIdParam>{

  final RacesRepository racesRepository;
  const LoadRaceEntryIdsForCollectionUseCase({required this.racesRepository});

  @override
  Future<Either<List<RaceEntryId>, Failure>> call(CollectionIdParam params) async {
    try {
      final loadedIds = racesRepository.readRaceEntryIds(
        params.collectionId,
      );

      return loadedIds.fold(
            (raceId) => Left(raceId),
            (failure) => Right(failure),
      );
    } on Exception catch(exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }

}