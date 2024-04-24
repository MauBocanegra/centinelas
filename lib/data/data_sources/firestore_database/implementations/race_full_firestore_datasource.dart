import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/race_full_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/models/race_full_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RaceFullFirestoreDatasource 
    implements RaceFullFirestoreDatasourceInterface {
  @override
  Future<RaceFullModel> fetchRaceFull(String raceId) async {

    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    final uid = serviceLocator<FirebaseAuth>().currentUser;

    late final RaceFullModel raceFullModel;

    try{
       /// fetch race information from racesCollection
       await firestore.doc(
         '$apiEnv/$racesCollectionKey/$raceId'
       ).get().then((DocumentSnapshot doc){
         final data = doc.data() as Map<String, dynamic>;
         raceFullModel = RaceFullModel(
             raceId: raceId,
             title: data[raceTitleKey],
             discipline: raceId.split('/').first,
             address: data['ubicacion'],
             description: data['descripcion'],
             imageUrl: data['linkImagen'],
             isRaceActive: data['esta_activa'] ?? false,
             isCheckInEnabled: data['checkin_abierto'] ?? false,
         );
       });

       /// we check if any race engagement state from user data exists
       late final bool hasRacesEngagementData;
       final snapshot = await firestore.doc(
           '$apiEnv/$usersInfoCollectionKey/${uid?.uid}/$userRacesDataKey'
       ).get();
       hasRacesEngagementData = snapshot.exists;

       if(hasRacesEngagementData){
         /// has race engagement data
         await firestore.doc(
             '$apiEnv/$usersInfoCollectionKey/${uid?.uid}/$userRacesDataKey'
         ).get().then((DocumentSnapshot doc){
           final data = doc.data() as Map<String, dynamic>;
           final hasCurrentRaceInfo = data.keys.contains(raceId);
           /// has race engagement data for current race
           if(hasCurrentRaceInfo){
             raceFullModel.raceEngagementState = data[raceId];
           } else {
             raceFullModel.raceEngagementState = raceEngagementEmpty;
           }
         }, onError: (e){
         });
       }else{
         /// NO race engagement data
         raceFullModel.raceEngagementState = raceEngagementEmpty;
       }
    } catch (e) {
      throw Exception('[raceFull Doc] fetch/mapping error');
    }

    return raceFullModel;
  }
}