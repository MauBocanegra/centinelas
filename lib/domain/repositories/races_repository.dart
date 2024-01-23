import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:either_dart/either.dart';

import '../entities/race_collection.dart';
import '../failures/failures.dart';

abstract class RacesRepository{
  //Future<Either<List<RaceCollection>, Failure>> readRacesCollections();
  Future<Either<RaceCollection, Failure>> readSingleRaceCollection();
  Future<Either<RaceEntry, Failure>> readRaceEntry(
    RaceEntryId raceEntryId
  );
  Future<Either<List<RaceEntryId>, Failure>> readRaceEntryIds();
  Future<Either<RaceFull, Failure>> readRaceFull(
      RaceEntryId raceEntryId,
  );
}