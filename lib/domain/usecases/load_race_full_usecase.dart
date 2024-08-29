import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/entities/race_full.dart';
import 'package:centinelas/domain/entities/unique_id.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class LoadRaceFullUseCase implements UseCase<RaceFull, RaceEntryId>{
  const LoadRaceFullUseCase({required this.racesRepository});
  final RacesRepository racesRepository;

  @override
  Future<Either<RaceFull, Failure>> call(RaceEntryId raceEntryId) async {
    try{
      final raceFull = racesRepository.readRaceFull(
        raceEntryId
      );

      return raceFull.fold(
          (raceFull) => Left(raceFull),
          (failure) => Right(failure),
      );
    } on Exception catch(exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}