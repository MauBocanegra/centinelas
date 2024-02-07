import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/utils/utils.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/incidence_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/sealed_classes/incidence_request_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class IncidenceWriteRealtimeDatasource
    implements IncidenceWriteRealtimeDataSourceInterface {

  final FirebaseDatabase firebase = serviceLocator<FirebaseDatabase>();
  final uid = serviceLocator<FirebaseAuth>().currentUser?.uid;

  @override
  Future<bool> writeIncidence(Map<String, dynamic> params) async {
    debugPrint(params.toString());

    DatabaseReference incidenceReference = firebase.ref("incidencias");
    late DatabaseReference incidenceIncidenceTypeReference;

    final newIncidenceKey = incidenceReference.push().key;
    final IncidenceRequestType incidenceRequestType = params[incidenceTypeKeyForMapping];
    debugPrint('incidenceRequestType: ${incidenceRequestType.toString()}');
    if(incidenceRequestType is SimpleIncidenceRequestType){
      debugPrint('IncidenceOfType Simple');
      incidenceIncidenceTypeReference = firebase.ref("asistencias-incidencias");
    } else if (incidenceRequestType is EmergencyIncidenceRequestType){
      debugPrint('IncidenceOfType Emergency');
      incidenceIncidenceTypeReference = firebase.ref("emergencias-incidencias");
    }

    DatabaseReference userIncidenceReference = firebase.ref("usuarios-incidencias/$uid");
    DatabaseReference raceIncidenceReference =
      firebase.ref("carreras-incidencias/${params[raceIdKeyForMapping]}");

    final incidenceData = {
      'carrera_id':params[raceIdKeyForMapping],
      'texto_incidencia': params[incidenceTextKeyForMapping],
      'hora_incidencia': '',
      'centinela_id': uid,
    };

    final date = getDate();

    final incidenceRelationData = {
      'timestamp' : '${date.hour}:${date.minute}:${date.second}'
    };

    final Map<String, Map> updates = {};
    updates[incidenceReference.path+'/'+(newIncidenceKey ?? '')] = incidenceData;
    updates[incidenceIncidenceTypeReference.path+'/'+(newIncidenceKey ?? '')] = incidenceRelationData;
    updates[userIncidenceReference.path+'/'+(newIncidenceKey ?? '')] = incidenceRelationData;
    updates[raceIncidenceReference.path+'/'+(newIncidenceKey ?? '')] = incidenceRelationData;

    late final bool wasAble;
    await firebase.ref().update(updates).then((_){
      wasAble = true;
    }).catchError((error){
      debugPrint('IncidenceWrite[Centinela] RealtimeDB error: ${error.toString()}');
      wasAble = false;
    });
    return wasAble;
  }
}