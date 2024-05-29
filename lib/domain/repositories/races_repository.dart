import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class RacesRepository{
  Future<Either<RaceEntry, Failure>> readRaceEntry(
    RaceEntryId raceEntryId
  );
  Future<Either<List<RaceEntryId>, Failure>> readRaceEntryIds();
  Future<Either<RaceFull, Failure>> readRaceFull(
      RaceEntryId raceEntryId,
  );
}