import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/race_collection_id_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/models/race_collection_id_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Downloads
class RaceCollectionIdFirestoreDatasource
    implements RaceCollectionIdFirestoreDatasourceInterface{
  @override
  Future<RaceCollectionIdModel> fetchRaceCollectionToDisplayId() async {
    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    late final String collectionIdToBeDisplayed;

    await firestore.doc(
        '$apiEnv/$collectionIdToBeDisplayedRoute'
    ).get().then((DocumentSnapshot doc){
      try {
        final data = doc.data() as Map<String, dynamic>;
        collectionIdToBeDisplayed = data[collectionIdToBeDisplayedId];
      } catch(e) {
        throw Exception('[collectionIdDoc] mapping error');
      }
    },
        onError: (e){
          debugPrint('DOC[collectionIdDoc] ERROR: $e');
          throw Exception('Unable to get collectionId from remote source');
        }
    );

    return RaceCollectionIdModel(
        raceCollectionId: collectionIdToBeDisplayed ?? ''
    );
  }

}