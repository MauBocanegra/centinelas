import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/data_sources/firestore_database/interfaces/users_list_firestore_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UsersListFirestoreDatasource
    implements UsersListFirestoreDatasourceInterface{

  @override
  Future<List<String>> fetchUsersList() async {
    final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
    late final List<String> usersList = [];

    await firestore.collection(apiEnv).get().then((snapshot) {
      final allDocs = snapshot.docs.map((doc) => doc.data()).toList();
      for (var doc in allDocs) {
        if (doc.isNotEmpty && doc.keys.first == userEmailsKeyForUser) {
          usersList.addAll(
              (doc.values.toList().firstOrNull as List<dynamic>)
                  .map((e) => e.toString())
          );
        }
      }
    }, onError: (e) {
      debugPrint('usersListDoc[ERROR] ERROR: $e');
      throw Exception('Unable to get collectionId from remote source');
    });
    return usersList;
  }
}