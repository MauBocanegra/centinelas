import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:firebase_database/firebase_database.dart';

Iterable<IncidenceModel> mapIterableDataSnapshotToIterableIncidenceModel(
    Iterable<DataSnapshot> iterableDataSnapshot
){
  Iterable<IncidenceModel> iterableIncidenceModel;
  iterableIncidenceModel = iterableDataSnapshot.map(
          (dataSnapshot) => IncidenceModel(
            raceId: (dataSnapshot.value as Map<dynamic, dynamic>)[raceIdRealtimeDBKey],
            centinelId: (dataSnapshot.value as Map<dynamic, dynamic>)[centinelIdRealtimeDBKey],
            time: (dataSnapshot.value as Map<dynamic, dynamic>)[incidenceTimeRealtimeDBKey],
            type: (dataSnapshot.value as Map<dynamic, dynamic>)[incidenceTypeRealtimeDBKey],
            text: (dataSnapshot.value as Map<dynamic, dynamic>)[incidenceTextRealtimeDBKey],
            lat: double.parse((dataSnapshot.value as Map<dynamic, dynamic>)[incidenceLatitudeRealtimeDBKey].toString()),
            lon: double.parse((dataSnapshot.value as Map<dynamic, dynamic>)[incidenceLongitudeRealtimeDBKey].toString()),
          )
  );
  return iterableIncidenceModel;
}
