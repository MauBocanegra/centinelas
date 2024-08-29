import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/data_sources/firestore_database/interfaces/races_collection_firestore_datesource_interface.dart';
import 'package:centinelas/data/models/race_collection_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RacesEntriesIdsFirestoreDatasource implements RacesEntriesIdsFirestoreDateSourceInterface {
  @override
  Future<RaceEntriesIdsModel> fetchRaceEntriesIdsList(String collectionIdToBeDisplayed) async {
    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    late final List<String> documentReferencesList;

    /// $collectionIdToBeDisplayed is a compound reference
    /// breaking it into a single reference will break the app
    await firestore.doc(
        '$apiEnv/${collectionIdToBeDisplayed.split('/').first}'
    ).get().then((DocumentSnapshot doc) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final eventsList = data[
            collectionIdToBeDisplayed.split('/').last
          ];
          if (eventsList is Iterable) {
            documentReferencesList = List<String>.from(eventsList);
          } else {
            documentReferencesList = List<String>.empty();
            throw Exception('[raceEntryIdsDoc] mapping error');
          }
        } catch (e) {
          debugPrint('Mapping [raceEntryIdsDoc] ERROR: $e');
          throw Exception('Unable to convert from RaceEntryIdsList Doc');
        }
      },
      onError: (e){
        debugPrint('DOC[raceEntryIds Doc] ERROR: $e');
        throw Exception('Unable to get RaceEntryIdsList Doc from firestore source');
      }
    );

    if(documentReferencesList.isNotEmpty){
      return RaceEntriesIdsModel(
          raceCollectionId: collectionIdToBeDisplayed,
          raceEntryIds: documentReferencesList,
      );
    } else {
      throw Exception('Unable to fetch RaceEntryIdsList from firestore source');
    }
  }

}