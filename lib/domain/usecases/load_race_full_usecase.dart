import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/helpers/race_id_collection_id.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';

class LoadRaceFullUseCase implements UseCase<RaceFull, RaceIdCollectionId>{
  const LoadRaceFullUseCase({required this.racesRepository});
  final RacesRepository racesRepository;

  @override
  Future<Either<RaceFull, Failure>> call(RaceIdCollectionId param) async {
    try{
      final raceFull = racesRepository.readRaceFull(
        param.collectionId,
        param.raceEntryId
      );

      return raceFull.fold(
          (raceFull) => Left(raceFull),
          (failure) => Right(failure),
      );
    } on Exception catch(exception) {
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}