import 'dart:async';

import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/data_sources/realtime_database/interfaces/incidence_observer_realtime_datasource_interface.dart';
import 'package:centinelas/data/mappers/iterable_datasnapshot_to_iterable_incidence_mapper.dart';
import 'package:centinelas/data/models/incidence_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class IncidenceObserverRealtimeDatasource implements IncidenceObserverRealtimeDatasourceInterface{
  final FirebaseDatabase firebase = serviceLocator<FirebaseDatabase>();
  final StreamController<DatabaseEvent> streamController = StreamController();
  final StreamController<Iterable<IncidenceModel>> outputStreamController = StreamController();

  @override
  StreamController<Iterable<IncidenceModel>>? getIncidenceModelStream(String raceId) {
    try{
      final databaseReference = firebase.ref().child(
          //'$racesIncidencesRealtimeDBPath/$raceId'
          incidencesRealtimeDBPath
      ).orderByChild(raceIdRealtimeDBKey).equalTo(raceId);
      streamController.addStream(databaseReference.onValue);
      streamController.stream.listen((event) {
        mapIterableDataSnapshotToIterableIncidenceModel(event.snapshot.children);
        outputStreamController.add(
            mapIterableDataSnapshotToIterableIncidenceModel(event.snapshot.children)
        );
      }, onDone: () {
        debugPrint("streamController done");
      }, onError: (error) {
        debugPrint("streamController error");
      });
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('Exception on incidence livestreaming: ${exception.toString()}');
    }
    return outputStreamController;
  }

  void finishStream(){
    streamController.close();
    outputStreamController.close();
  }

}