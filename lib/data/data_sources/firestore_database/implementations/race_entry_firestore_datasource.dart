import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/data_sources/firestore_database/interfaces/race_entry_firestore_datasource_interface.dart';
import 'package:centinelas/data/mappers/race_entry_doc_to_race_entry_model_mapper.dart';
import 'package:centinelas/data/models/race_entry_model.dart';
import 'package:centinelas/domain/utils/storage_image_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class RaceEntryFirestoreDatasource implements
    RaceEntryFirestoreDatasourceInterface {

  @override
  Future<RaceEntryModel> fetchRaceEntry(String raceEntryId) async {
    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    late final RaceEntryModel raceEntryModel;

    await firestore.doc(
      '$apiEnv/$raceEntryCollectionKey/$raceEntryId'
    ).get().then((DocumentSnapshot doc) async {
      try {
        final data = doc.data() as Map<String, dynamic>;
        data[raceEntryIdKey] = raceEntryId;
        data[raceEntryImageKey] = await getImageUrl(data[raceEntryImageKey]);
        raceEntryModel = mapRaceEntryDocToRaceEntryModel(data);
      } catch(exception){
        serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
        raceEntryModel = RaceEntryModel.empty();
        throw Exception('[raceEntry] mapping error');
      }
    }, onError: (e){
      debugPrint('DOC[raceEntry] ERROR: $e');
      throw Exception('Unable to get raceEntry from remote source');
    });

    return raceEntryModel;
  }
}