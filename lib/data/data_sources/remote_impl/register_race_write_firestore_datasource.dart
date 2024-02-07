import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/interfaces/register_race_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WriteEngagementRaceFirestoreDatasource implements
    WriteEngagementRaceFirestoreDatasourceInterface {

  final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
  final uid = serviceLocator<FirebaseAuth>().currentUser?.uid;

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
        debugPrint('writeRaceRegistration EXCEPTION: ${error.toString()}');
        throw Exception('Unable to writeRaceRegistration from remote source');
      });
      return true;
    } on Exception catch (exception) {
      debugPrint('writeRaceRegistration EXCEPTION: ${exception.toString()}');
      throw Exception('Unable to writeRaceRegistration from remote source');
    }
  }

}