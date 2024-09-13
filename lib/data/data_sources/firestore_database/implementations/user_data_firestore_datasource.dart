import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/data_sources/firestore_database/interfaces/user_data_firestore_datasource_interface.dart';
import 'package:centinelas/data/mappers/user_data_doc_to_user_data_model.dart';
import 'package:centinelas/domain/entities/user_data_model.dart';
import 'package:centinelas/domain/utils/user_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class UserDataFirestoreDatasource implements
    UserDataFirestoreDatasourceInterface{

  final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
  final String uid = getUserId() ?? '';

  late final UserDataModel userDataModel;

  @override
  Future<UserDataModel> fetchUserData() async {
    try{

      debugPrint(
          'aiEnv: $apiEnv, '
          'usersInfoCollectionKey: $usersInfoCollectionKey, '
          'id: $uid, '
          'userDataKey: $userDataKey'
      );
      await firestore.doc(
        '$apiEnv/$usersInfoCollectionKey/$uid/$userDataKey'
      ).get().then((DocumentSnapshot doc){
        final data = doc.data() as Map<String, dynamic>;
        debugPrint('fetchUserData: ${data.toString()}');
        userDataModel = userDataDocToUserDataModel(data);
      }).onError((error, stackTrace){
        throw Exception('[fetchUserData Doc] doc/mapping error');
      });
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      throw Exception('[fetchUserData] error getting userData: ${exception.toString()}');
    }

    return userDataModel;
  }

  @override
  Future<UserDataModel> fetchCustomUserData(String userId) async {
    try{
      debugPrint(
          'aiEnv: $apiEnv, '
              'usersInfoCollectionKey: $usersInfoCollectionKey, '
              'id: $uid, '
              'userDataKey: $userDataKey'
      );
      await firestore.doc(
          '$apiEnv/$usersInfoCollectionKey/$userId/$userDataKey'
      ).get().then((DocumentSnapshot doc){
        final data = doc.data() as Map<String, dynamic>;
        debugPrint('fetchCustomUserData: ${data.toString()}');
        userDataModel = userDataDocToUserDataModel(data);
      }).onError((error, stackTrace){
        throw Exception('[fetchCustomUserData Doc] doc/mapping error');
      });
    } on Exception catch(e){
      serviceLocator<FirebaseCrashlytics>().recordError(e, null);
      throw Exception('[fetchCustomUserData] error getting userData: ${e.toString()}');
    }

    return userDataModel;
  }

  @override
  Future<bool> updateUserData(UserDataModel userDataModel) async {
    try{
      await firestore.doc(
        '$apiEnv/$usersInfoCollectionKey/$uid/$userDataKey'
      ).set({
        userDataPhoneKey : userDataModel.phone,
        userDataEmergencyContactNameKey: userDataModel.emergencyContactName,
        userDataEmergencyContactPhoneKey: userDataModel.emergencyContactPhone,
        userDataSevereAllergiesKey: userDataModel.severeAllergies,
        userDataDrugSensitivitiesKey: userDataModel.drugSensitivities

      }, SetOptions(merge: true)).onError((error, stackTrace){
        //debugPrint('writeUserData EXCEPTION: ${error.toString()}');
        throw Exception('Unable to userDataModel to firestore');
      });
      return true;
    } on Exception catch (exception) {
      debugPrint('writeUserDAta EXCEPTION: ${exception.toString()}');
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      throw Exception('Unable to writeUserData to firestore');
    }
  }

  @override
  Future<bool> verifyUserHasDispatchClearance() async {
    try{
      late final bool hasDispatchClearance;
      final userEmail = serviceLocator<FirebaseAuth>().currentUser?.email;
      await firestore.doc(
        '$apiEnv/$adminsDataKey'
      ).get().then((DocumentSnapshot doc){
        final data = doc.data() as Map<String, dynamic>;
        //debugPrint('dispatchFetched data: ${data.toString()}');
        if(
          (data[dispatchersDataKey] as List).contains(userEmail) ||
              (data[dispatchersDataKey] as List).contains(uid)
        ){
          //debugPrint('hasClearance from userDatasource');
          hasDispatchClearance = true;
        }else{
          //debugPrint('DENIEDClearance from userDatasource');
          hasDispatchClearance = false;
        }
      }).onError((error, stackTrace){
        hasDispatchClearance = false;
        serviceLocator<FirebaseCrashlytics>().recordError(error, null);
        throw Exception('[despachadores Doc] doc/mapping error');
      });
      return hasDispatchClearance;
    } on Exception catch (exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('verifyUserDispatchClearance EXCEPTION: ${exception.toString()}');
      throw Exception('Unable to verifyUserDispatchClearance from firestore');
    }
  }
}