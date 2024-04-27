import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

class LoadRaceEntryUseCase implements UseCase<RaceEntry, RaceEntryId>{
  const LoadRaceEntryUseCase({required this.raceRepository,});
  final RacesRepository raceRepository;

  @override
  Future<Either<RaceEntry, Failure>> call(RaceEntryId raceEntryId) async {
    try {
      final loadedEntry = raceRepository.readRaceEntry(
        raceEntryId
      );

      return loadedEntry.fold(
              (raceEntry) => Left(raceEntry),
              (failure) => Right(failure),
      );
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('error at LoadRaceEntryUseCase: ${exception.toString()}');
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }


}