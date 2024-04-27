import 'dart:async';

import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/user_data_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/dispatcher_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/incidence_observer_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/incidence_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:centinelas_app/domain/repositories/realtime_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class RealtimeRepositoryImpl extends RealtimeRepository{
  RealtimeRepositoryImpl();

  final  incidenceObserverRealtimeDatasource =
    serviceLocator<IncidenceObserverRealtimeDatasourceInterface>();
  final StreamController<Iterable<IncidenceModel>> outputStreamController = StreamController();

  @override
  Future<bool> writeDispatcherInRealtimeDB() async {
    try{
      final writeDispatcherInRTDBDatasource =
          serviceLocator<DispatcherWriteRealtimeDatasourceInterface>();
      final wasAbleToWriteDispatcher =
          await writeDispatcherInRTDBDatasource.writeDispatcher();
      return wasAbleToWriteDispatcher;
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('Error WriteIncidenceRealtimeDB: ${exception.toString()}');
      return false;
    }
  }

  @override
  Future<bool> writeIncidenceInRealtimeDB(Map<String, dynamic> data) async {
    try{
      final writeIncidenceRealtimeDatasource =
          serviceLocator<IncidenceWriteRealtimeDataSourceInterface>();
      final wasAbleToWriteIncidence =
          await writeIncidenceRealtimeDatasource.writeIncidence(data);
      return wasAbleToWriteIncidence;
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('Error WriteIncidenceRealtimeDB: ${exception.toString()}');
      return false;
    }
  }

  @override
  StreamController<Iterable<IncidenceModel>> getIncidenceModelStream() {
    try{
      final incidenceModelStream =
        incidenceObserverRealtimeDatasource.getIncidenceModelStream();
      incidenceModelStream?.stream.listen((event) {
        outputStreamController.add(event);
      });
      return outputStreamController;
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('Error WriteIncidenceRealtimeDB: ${exception.toString()}');
      return outputStreamController;
    }
  }
}