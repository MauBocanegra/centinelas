import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/reports_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:centinelas_app/data/models/report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReportsFirestoreDatasource implements ReportsFirestoreDatasourceInterface{

  final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
  final FirebaseDatabase firebase = serviceLocator<FirebaseDatabase>();
  final String uid = serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';

  late final ReportModel reportModel;

  @override
  Future<List<ReportModel>> fetchRacesReports() async {
    late Map<String, dynamic> dataCollectionRoute;
    late Map<String, dynamic> dataCollection;
    late Map<String, dynamic> raceLogs;
    try{
      /// get app displayed events
      await firestore.doc(
        '$apiEnv/$collectionIdToBeDisplayedRoute'
      ).get().then((DocumentSnapshot doc){
        dataCollectionRoute = doc.data() as Map<String, dynamic>;
      });
      /// get all collections
      await firestore.doc(
        '$apiEnv/${dataCollectionRoute[collectionIdToBeDisplayedId]
            .toString().split('/').first}'
      ).get().then((DocumentSnapshot doc){
        dataCollection = doc.data() as Map<String, dynamic>;
      });
      /// get race ids
      final collectionId = dataCollectionRoute[collectionIdToBeDisplayedId]
          .toString().split('/').last;
      /// get full race logs
      final String uid = serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';
      await firestore.doc(
        '$apiEnv/$usersInfoCollectionKey/$uid/$userRacesDataKey'
      ).get().then((DocumentSnapshot doc){
        raceLogs = doc.data() as Map<String, dynamic>;
      });

      /// get incidenceId's for current user
      DatabaseReference incidenceUserReference =
        firebase.ref(usersIncidencesRealtimeDBPath);
      final incidenceUserSnapshot =
      await incidenceUserReference.child(uid).get();

      /// fill each report
      List<ReportModel> reports = [];
      for (var raceId in (dataCollection[collectionId] as List)) {
        if(raceLogs.isEmpty){continue;}
        Map<String, dynamic>? raceLog = raceLogs['$raceActivityLog$raceId'];
        ReportModel reportModel = ReportModel();
        reportModel.raceIdString = raceId;
        if(raceLog!=null) {
          reportModel.raceLog = raceLog;
        }else{
          reportModel.raceLog = {};
        }

        DatabaseReference incidenceRaceReference =
          firebase.ref(racesIncidencesRealtimeDBPath);
        final snapshot = await incidenceRaceReference.child(raceId).get();
        List<List<dynamic>> crossIncidences = [];
        if(incidenceUserSnapshot.exists){
          crossIncidences.add(
              (incidenceUserSnapshot.value as Map<dynamic, dynamic>)
                  .keys.toList()
          );
        }
        if (snapshot.exists) {
          crossIncidences.add(
              (snapshot.value as Map<dynamic, dynamic>).keys.toList()
          );
        }
        if(crossIncidences.length<2){crossIncidences.clear();}
        if(crossIncidences.isNotEmpty) {
          /// keep only duplicated
          crossIncidences.first.removeWhere(
                  (element) => !crossIncidences.last.contains(element)
          );
          for (var incidenceId in crossIncidences.first) {
            /// Get each incidence model
            DatabaseReference incidenceReference =
            firebase.ref(incidencesRealtimeDBPath);
            final incidenceSnapshot = await incidenceReference.child(
                incidenceId).get();
            if (incidenceSnapshot.exists) {
              reportModel.incidencesList.add(
                  mapIncidenceSnapshotToIncidenceModel(incidenceSnapshot)
              );
            }
          }
        }

        /// get race name
        await firestore.doc(
            '$apiEnv/$racesCollectionKey/$raceId'
        ).get().then((DocumentSnapshot doc){
          Map<String, dynamic> fullRace = doc.data() as Map<String, dynamic>;
          reportModel.raceNameString = fullRace[raceTitleKey];
        });

        if(!(reportModel.raceLog.isEmpty
            && reportModel.incidencesList.isEmpty)){
          reports.add(reportModel);
        }
      }
      debugPrint('reportModel: ${reports.toString()}');
      return reports;
    } on Exception catch(e){
      serviceLocator<FirebaseCrashlytics>().recordError(e, null);
      return [];
    }
  }

  IncidenceModel mapIncidenceSnapshotToIncidenceModel(DataSnapshot incidenceSnapshot){
    debugPrint('incidenceSnapshot: ${incidenceSnapshot.value}');
    return IncidenceModel(
      raceId: (incidenceSnapshot.value as Map<dynamic, dynamic>)[raceIdRealtimeDBKey],
      centinelId: (incidenceSnapshot.value as Map<dynamic, dynamic>)[centinelIdRealtimeDBKey],
      time: (incidenceSnapshot.value as Map<dynamic, dynamic>)[incidenceTimeRealtimeDBKey],
      type: (incidenceSnapshot.value as Map<dynamic, dynamic>)[incidenceTypeRealtimeDBKey],
      text: (incidenceSnapshot.value as Map<dynamic, dynamic>)[incidenceTextRealtimeDBKey],
      lat: double.parse((incidenceSnapshot.value as Map<dynamic, dynamic>)[incidenceLatitudeRealtimeDBKey].toString()),
      lon: double.parse((incidenceSnapshot.value as Map<dynamic, dynamic>)[incidenceLongitudeRealtimeDBKey].toString()),
    );
  }

}