import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/data_sources/firestore_database/interfaces/register_race_write_firestore_datasource_interface.dart';
import 'package:centinelas/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas/domain/utils/user_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class WriteEngagementRaceFirestoreDatasource implements
    WriteEngagementRaceFirestoreDatasourceInterface {

  final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
  final uid = getUserId();

  @override
  Future<bool> writeRaceEngagement(
      String raceId,
      RaceEngagementRequestType engagementType,
  ) async {
    try{
      late final String engagementString;
        if(engagementType is RegisterEngagementRequest){
          engagementString = raceEngagementRegistered;
        } else if (engagementType is CheckInEngagementRequest){
          engagementString = raceEngagementCheckedIn;
        } else {
          debugPrint('invalidEngagementType EXCEPTION');
          throw Exception('invalidEngagementType EXCEPTION');
        }
      await firestore.doc(
        '$apiEnv/$usersInfoCollectionKey/$uid/$userRacesDataKey'
      ).set({ raceId: engagementString },
        SetOptions(merge: true)
      ).onError((error, stackTrace){
        serviceLocator<FirebaseCrashlytics>().recordError(error, null);
        debugPrint('writeRaceRegistration EXCEPTION: ${error.toString()}');
        throw Exception('Unable to writeRaceRegistration from remote source');
      });

      int timestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      var arrayData = {
        engagementString : timestamp
      };
      await firestore.doc(
          '$apiEnv/$usersInfoCollectionKey/$uid/$userRacesDataKey'
      ).set({
          '$raceActivityLog$raceId' : arrayData
      },
          SetOptions(merge: true)
      ).onError((error, stackTrace){
        debugPrint('writeRaceRegistration ERROR: ${error.toString()}');
        throw Exception('Unable to writeRaceRegistration from remote source');
      });

      return true;
    } on Exception catch (exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('writeRaceRegistration EXCEPTION: ${exception.toString()}');
      throw Exception('Unable to writeRaceRegistration from remote source');
    }
  }

}