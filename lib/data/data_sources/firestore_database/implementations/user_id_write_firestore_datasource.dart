import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/user_id_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/domain/utils/user_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class UserIdWriteFirsetoreDatasource implements
    UserIdWriteFirestoreDatasourceInterface{
  @override
  Future<bool> writeUserID() async {
    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    final uid = getUserId();

    try {
      final int timestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      final DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);

      await firestore.doc(
          '$apiEnv/$usersInfoCollectionKey/$uid/$userDataKey'
      ).set(
        {
          lastActiveDayKeyForUser:
            '${tsdate.day}/'
            '${tsdate.month}/'
            '${tsdate.year}',
          userEmailKeyForUser: serviceLocator<FirebaseAuth>().currentUser?.email,
        },
        SetOptions(merge: true),
      ).onError((error, stackTrace) {
        debugPrint('write[UserID] ERROR: $error');
        serviceLocator<FirebaseCrashlytics>().recordError(error, null);
        throw Exception('Unable to set userID UserIdWriteFirestore');
      });

      await firestore.doc(
          '$apiEnv/$usersInfoCollectionKey'
      ).update(
        {
          userEmailsKeyForUser: FieldValue.arrayUnion([
            serviceLocator<FirebaseAuth>().currentUser?.email
          ]),
        },
      ).onError((error, stackTrace) {
        debugPrint('write[UserEmail] ERROR: $error');
        serviceLocator<FirebaseCrashlytics>().recordError(error, null);
        throw Exception('Unable to set userEmail UserIdWriteFirestore');
      });

      return true;
    } on Exception catch(exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('writeLoggedUser EXCEPTION: ${exception.toString()}');
      throw Exception('Unable to writeLoggedUser from remote source');
    }
  }
}