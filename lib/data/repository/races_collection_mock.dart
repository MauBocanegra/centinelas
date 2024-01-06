import 'dart:math';

import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:either_dart/either.dart';

import '../../domain/entities/race_collection.dart';
import '../../domain/entities/race_color.dart';
import '../../domain/entities/unique_id.dart';
import '../../domain/failures/failures.dart';
import '../../domain/repositories/races_repository.dart';

const numberOfMockedRaces = 10;
const maxNumberOfMockedRaces = 100;
const waitInMilis = 200;

class RacesRepositoryMock implements RacesRepository {

  final List<RaceEntry> raceEntries = List.generate(
      maxNumberOfMockedRaces,
      (index) => RaceEntry(
        id: RaceEntryId.fromUniqueString(index.toString()),
        description: 'description $index',
      ),
  );

  final raceCollections = List<RaceCollection>.generate(
    numberOfMockedRaces,
        (index) => RaceCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      color: RaceColor(colorIndex: index % RaceColor.predifinedColors.length),
    ),
  );

  @override
  Future<Either<List<RaceCollection>, Failure>> readRacesCollections() {
    try{
      return Future.delayed(
          const Duration(milliseconds: waitInMilis),
              () => Left(raceCollections)
      );
    } on Exception catch(exception){
      return Future.value(Right(ServerFailure(stackTrace: exception.toString())));
    }
  }

  @override
  Future<Either<RaceEntry, Failure>> readRaceEntry(CollectionId collectionId, RaceEntryId raceEntryId) {
    try{
      final selectedEntryItem = raceEntries.firstWhere((element) => element.id == raceEntryId);
      return Future.delayed(
          const Duration(milliseconds: waitInMilis),
              () => Left(selectedEntryItem)
      );
    } on Exception catch(exception){
      return Future.value(Right(ServerFailure(stackTrace: exception.toString())));
    }
  }

  @override
  Future<Either<List<RaceEntryId>, Failure>> readRaceEntryIds(CollectionId collectionId) {
    try{
      final startIndex = int.parse(collectionId.value) * numberOfMockedRaces;
      final endIndex = startIndex + numberOfMockedRaces;
      final entryIds = raceEntries.sublist(
          startIndex,
          endIndex
      ).map((entry) => entry.id).toList();
      return Future.delayed(
        const Duration(milliseconds: waitInMilis),
        () => Left(entryIds)
      );
    } on Exception catch(exception){
      return Future.value(Right(ServerFailure(stackTrace: exception.toString())));
    }
  }

  @override
  Future<Either<RaceCollection, Failure>> readSingleRaceCollection() {
    try{
      //raceCollections
      return Future.delayed(
        const Duration(milliseconds: waitInMilis),
        () => Left(raceCollections[Random().nextInt(raceCollections.length)]),
      );
    } on Exception catch(exception){
      return Future.value(Right(ServerFailure(stackTrace: exception.toString())));
    }
  }


}