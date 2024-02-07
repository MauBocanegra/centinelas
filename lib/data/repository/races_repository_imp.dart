import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/race_collection_id_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/race_entry_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/race_full_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/races_collection_firestore_datesource_interface.dart';
import 'package:centinelas_app/data/mappers/race_entries_ids_model_to_list_race_entry_id_mapper.dart';
import 'package:centinelas_app/data/mappers/race_entry_model_to_race_entry_mapper.dart';
import 'package:centinelas_app/data/mappers/race_full_model_to_race_full_mapper.dart';
import 'package:centinelas_app/domain/entities/race_collection.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:flutter/material.dart';

class RacesRepositoryImpl extends RacesRepository{

  RacesRepositoryImpl();

  @override
  Future<Either<RaceEntry, Failure>> readRaceEntry(RaceEntryId raceEntryId) async {
    try{
      final raceEntryFirestoreDatasource =
          serviceLocator<RaceEntryFirestoreDatasourceInterface>();
      final raceEntryModel = await raceEntryFirestoreDatasource.fetchRaceEntry(raceEntryId.value);
      return Left(mapRaceEntryModelToRaceEntry(raceEntryModel));
    } on Exception catch(exception){
      return Future.value(Right(ServerFailure(stackTrace: exception.toString())));
    }
  }

  @override
  Future<Either<List<RaceEntryId>, Failure>> readRaceEntryIds() async {
    try {
      final raceCollectionIdFirestoreDatasource =
        serviceLocator<RaceCollectionIdFirestoreDatasourceInterface>();
      final racesFirestoreDataSource =
        serviceLocator<RacesEntriesIdsFirestoreDateSourceInterface>();

      final raceCollectionIdModel = await raceCollectionIdFirestoreDatasource
        .fetchRaceCollectionToDisplayId();

      final raceEntriesIdsModel = await racesFirestoreDataSource
        .fetchRaceEntriesIdsList(raceCollectionIdModel.raceCollectionId);

      return Left(mapRaceEntriesIdsModelToRaceEntryIdList(raceEntriesIdsModel));

    } on Exception catch(exception) {
      return Future.value(Right(ServerFailure(stackTrace: exception.toString())));
    }
  }

  @override
  Future<Either<RaceFull, Failure>> readRaceFull(RaceEntryId raceEntryId) async {
    try {
      final raceFullFirestoreDatasource = serviceLocator<
          RaceFullFirestoreDatasourceInterface>();

      final raceFullModel = await raceFullFirestoreDatasource.fetchRaceFull(
          raceEntryId.value);

      return Left(mapRaceFullModelToRaceFull(raceFullModel));

    } on Exception catch(e){
      return Future.value(Right(ServerFailure(stackTrace: e.toString())));
    }

  }

  @override
  Future<Either<List<RaceCollection>, Failure>> readRacesCollections() async {
    try {

      final raceCollectionIdFirestoreDatasource =
        serviceLocator<RaceCollectionIdFirestoreDatasourceInterface>();
      final racesFirestoreDataSource =
        serviceLocator<RacesEntriesIdsFirestoreDateSourceInterface>();

      final raceCollectionIdModel = await raceCollectionIdFirestoreDatasource
          .fetchRaceCollectionToDisplayId();

      final raceEntriesIds = await racesFirestoreDataSource.fetchRaceEntriesIdsList(
          raceCollectionIdModel.raceCollectionId
      );


      // TODO map whatever fetchRaceCollections return to comply to this returning type

      return Future.value(Left(
          List<RaceCollection>.generate(
            0,
            (index) => RaceCollection(
                id: CollectionId(),
                raceCollectionTitle: '',
            )
          )
      ));
    } on Exception catch(exception) {
      debugPrint('inRacesRepositoryImp: $exception');
      return Future.value(Right(
          ServerFailure(stackTrace: exception.toString())
      ));
    }
  }

  @override
  Future<Either<RaceCollection, Failure>> readSingleRaceCollection() {
    // TODO: implement readSingleRaceCollection
    return Future.value(Right(ServerFailure(stackTrace: '')));
  }
  
}