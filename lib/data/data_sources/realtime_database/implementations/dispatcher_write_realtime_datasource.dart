import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/dispatcher_write_realtime_datasource_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DispatcherWriteRealtimeDatasource
    implements DispatcherWriteRealtimeDatasourceInterface{

  final String userEmail = serviceLocator<FirebaseAuth>().currentUser?.email ?? '';
  final String userId = serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';
  final String uid = serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';

  @override
  Future<bool> writeDispatcher() async {
    final FirebaseDatabase realtimeDatabase = serviceLocator<FirebaseDatabase>();
    late final bool wasAble;
    try{
      DatabaseReference incidenceReference = realtimeDatabase.ref(dispatchersRealtimeDBPath);
      wasAble = false;
    } on Exception catch(exception){
      debugPrint('IncidenceWrite[Centinela] RealtimeDB error: ${exception.toString()}');
      wasAble = false;
    }
    return wasAble;
  }

}