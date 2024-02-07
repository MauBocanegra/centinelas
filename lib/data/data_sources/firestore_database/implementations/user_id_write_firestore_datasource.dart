import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/user_id_write_firestore_datasource_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserIdWriteFirsetoreDatasource implements
    UserIdWriteFirestoreDatasourceInterface{
  @override
  Future<bool> writeUserID(String uid) async {
    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();

    try {
      final int timestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      final DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);

      await firestore.doc(
          '$apiEnv/$usersInfoCollectionKey/$uid/$userDataKey'
      ).set(
        { lastActiveDayKeyForUser:
            '${tsdate.day}/'
            '${tsdate.month}/'
            '${tsdate.year}'
        },
        SetOptions(merge: true),
      ).onError((error, stackTrace) {
        debugPrint('write[UserID] ERROR: $error');
        throw Exception('Unable to set userID from remote source');
      });
      return true;
    } on Exception catch(exception) {
      debugPrint('writeLoggedUser EXCEPTION: ${exception.toString()}');
      throw Exception('Unable to writeLoggedUser from remote source');
    }
  }
}