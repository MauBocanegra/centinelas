import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/utils/utils.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/incidence_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/sealed_classes/incidence_request_type.dart';
import 'package:centinelas_app/domain/utils/user_utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class IncidenceWriteRealtimeDatasource
    implements IncidenceWriteRealtimeDataSourceInterface {

  final FirebaseDatabase firebase = serviceLocator<FirebaseDatabase>();
  final uid = getUserId();

  @override
  Future<bool> writeIncidence(Map<String, dynamic> params) async {
    DatabaseReference incidenceReference = firebase.ref(incidencesRealtimeDBPath);
    late DatabaseReference incidenceIncidenceTypeReference;

    final newIncidenceKey = incidenceReference.push().key;
    final IncidenceRequestType incidenceRequestType = params[incidenceTypeKeyForMapping];
    late final String incidenceTypeString;
    if(incidenceRequestType is SimpleIncidenceRequestType){
      incidenceTypeString = incidenceAssistanceTypeForMapping;
      incidenceIncidenceTypeReference = firebase.ref(assistanceIncidencesRealtimeDBPath);
    } else if (incidenceRequestType is EmergencyIncidenceRequestType){
      incidenceTypeString = incidenceEmergencyTypeForMapping;
      incidenceIncidenceTypeReference = firebase.ref(emergencyIncidencesRealtimeDBPath);
    }

    DatabaseReference userIncidenceReference = firebase.ref("$usersIncidencesRealtimeDBPath/$uid");
    DatabaseReference raceIncidenceReference =
      firebase.ref("$racesIncidencesRealtimeDBPath/${params[raceIdKeyForMapping]}");

    final date = getDate();

    final incidenceRelationData = {
      'timestamp' : '${date.hour}:${date.minute}:${date.second}'
    };

    final incidenceData = {
      raceIdRealtimeDBKey : params[raceIdKeyForMapping],
      incidenceTextRealtimeDBKey : params[incidenceTextKeyForMapping],
      incidenceTimeRealtimeDBKey : '${date.hour}:${date.minute}:${date.second}',
      incidenceTypeRealtimeDBKey : incidenceTypeString,
      centinelIdRealtimeDBKey : uid,
      incidenceLatitudeRealtimeDBKey : params[incidenceLatitudeKeyForMapping],
      incidenceLongitudeRealtimeDBKey : params[incidenceLongitudeKeyForMapping],
    };

    final Map<String, Map> updates = {};
    updates['${incidenceReference.path}/${newIncidenceKey ?? ''}'] = incidenceData;
    updates['${incidenceIncidenceTypeReference.path}/${newIncidenceKey ?? ''}'] = incidenceRelationData;
    updates['${userIncidenceReference.path}/${newIncidenceKey ?? ''}'] = incidenceRelationData;
    updates['${raceIncidenceReference.path}/${newIncidenceKey ?? ''}'] = incidenceRelationData;

    late final bool wasAble;
    await firebase.ref().update(updates).then((_){
      wasAble = true;
    }).catchError((error){
      debugPrint('IncidenceWrite[Centinela] RealtimeDB error: ${error.toString()}');
      serviceLocator<FirebaseCrashlytics>().recordError(error, error.stackTrace);
      wasAble = false;
    });
    return wasAble;
  }
}