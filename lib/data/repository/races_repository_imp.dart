import 'package:centinelas_app/domain/entities/race_collection.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:http/http.dart';

class RacesRepositoryImpl extends RacesRepository{

  final Client client;
  RacesRepositoryImpl({required this.client});

  @override
  Future<Either<RaceEntry, Failure>> readRaceEntry(CollectionId collectionId, RaceEntryId raceEntryId) {
    // TODO: implement readRaceEntry
    throw UnimplementedError();
  }

  @override
  Future<Either<List<RaceEntryId>, Failure>> readRaceEntryIds(CollectionId collectionId) {
    // TODO: implement readRaceEntryIds
    throw UnimplementedError();
  }

  @override
  Future<Either<RaceFull, Failure>> readRaceFull(CollectionId collectionId, RaceEntryId raceEntryId) {
    // TODO: implement readRaceFull
    throw UnimplementedError();
  }

  @override
  Future<Either<List<RaceCollection>, Failure>> readRacesCollections() {
    // TODO: implement readRacesCollections
    throw UnimplementedError();
  }

  @override
  Future<Either<RaceCollection, Failure>> readSingleRaceCollection() {
    // TODO: implement readSingleRaceCollection
    throw UnimplementedError();
  }
  
}