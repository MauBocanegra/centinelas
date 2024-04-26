import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/dispatcher_write_realtime_datasource_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
      DatabaseReference dispatcherReference = realtimeDatabase.ref(
          "$dispatchersRealtimeDBPath/$userId"
      );
      final fcmToken = await serviceLocator<FirebaseMessaging>().getToken(
          vapidKey: fcmVapidKey
      );
      final dispatcherData = {
        dispatcherFCMTokenRealtimeDBKey : fcmToken,
        dispatcherEmailRealtimeDBKey : userEmail,
      };
      final Map<String, Map> updates = {};
      updates[dispatcherReference.path] = dispatcherData;
      await realtimeDatabase.ref().update(updates).then((_){
        wasAble = true;
      }).catchError((error){
        debugPrint('DispatcherWrite RealtimeDB error: ${error.toString()}');
        wasAble = false;
      });
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('IncidenceWrite[Centinela] RealtimeDB error: ${exception.toString()}');
      wasAble = false;
    }
    return wasAble;
  }
}