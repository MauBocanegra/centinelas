import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/interfaces/race_full_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/models/race_full_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RaceFullFirestoreDatasource 
    implements RaceFullFirestoreDatasourceInterface {
  @override
  Future<RaceFullModel> fetchRaceFull(String raceId) async {

    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    late final RaceFullModel raceFullModel;

    try{
       await firestore.doc(
         '$apiEnv/$racesCollectionKey/$raceId'
       ).get().then((DocumentSnapshot doc){
         final data = doc.data() as Map<String, dynamic>;
         raceFullModel = RaceFullModel(
             raceId: raceId,
             title: data['titulo'],
             discipline: raceId.split('/').first,
             address: data['ubicacion'],
             description: data['descripcion'],
             imageUrl: data['linkImagen'],
         );
       });
    } catch (e) {
      throw Exception('[raceFull Doc] fetch/mapping error');
    }

    return raceFullModel;
  }
}