import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/register_race_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/user_data_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/user_id_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/dispatcher_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas_app/domain/entities/user_data_model.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:flutter/material.dart';

class UsersRepositoryImpl extends UsersRepository{

  UsersRepositoryImpl();

  @override
  Future<bool> writeDispatcherInRealtimeDatabase() async {
    try{
      final dispatcherWriteRealtimeDatasource =
        serviceLocator<DispatcherWriteRealtimeDatasourceInterface>();
      final wasAbleToWriteDispatcherInRealtime =
          dispatcherWriteRealtimeDatasource.writeDispatcher();
      return wasAbleToWriteDispatcherInRealtime;
    } on Exception catch(exception){
      debugPrint('Exception writeDispatcherInRealtimeDatabase: ${exception.toString()}');
      return false;
    }
  }

  @override
  Future<bool> writeLoggedUserInFirestore(String uid) async {
    try{
      final userIdWriteFirestoreDatasource =
          serviceLocator<UserIdWriteFirestoreDatasourceInterface>();
      final wasAbleToWriteUserId =
        await userIdWriteFirestoreDatasource.writeUserID(uid);
      return wasAbleToWriteUserId;
    } on Exception catch(exception){
      return false;
    }
  }

  @override
  Future<bool> writeRaceEngagementInFirestore(
    String raceId,
    RaceEngagementRequestType engagementType
  ) async {
    try{
      final writeRaceEngagementFirestoreDatasource =
          serviceLocator<WriteEngagementRaceFirestoreDatasourceInterface>();
      final wasAbleToWriteRaceEngagement =
          await writeRaceEngagementFirestoreDatasource
              .writeRaceEngagement(raceId, engagementType);
      return wasAbleToWriteRaceEngagement;
    }on Exception catch(exception){
      return false;
    }
  }

  @override
  Future<Either<UserDataModel, Failure>> readUserData() async {
    try{
      final userDataFirestoreDatasource =
          serviceLocator<UserDataFirestoreDatasourceInterface>();
      final userDataModel = await userDataFirestoreDatasource.fetchUserData();
      return Left(userDataModel);
    } on Exception catch(exception){
      return Future.value(Right(
          ServerFailure(stackTrace: exception.toString())
      ));
    }
  }

  @override
  Future<bool> updateUserData(UserDataModel data) async {
    try{
      final userDataFirestoreDatasource =
        serviceLocator<UserDataFirestoreDatasourceInterface>();
      final wasAbleToUpdateData =
        await userDataFirestoreDatasource.updateUserData(data);
      return wasAbleToUpdateData;
    } on Exception catch(exception){
      debugPrint('error updating UserData[UsersRepository]: '
          '${exception.toString()}');
      return false;
    }
  }

  @override
  Future<bool> isCurrentUserDispatchAuthorized() async {
    try{
      final userDataFirestoreDatasource =
        serviceLocator<UserDataFirestoreDatasourceInterface>();
      final userHasDispatchClearance =
          await userDataFirestoreDatasource.verifyUserHasDispatchClearance();
      return userHasDispatchClearance;
    } on Exception catch(exception){
      debugPrint('error isCurrentUserDispatchAuthorized[UsersRepository]: '
          '${exception.toString()}');
      return false;
    }
  }

  @override
  Future<Either<UserDataModel, Failure>> readCustomUserData(
    String customUserId
  ) async{
    try{
      final userDataFirestoreDatasource =
        serviceLocator<UserDataFirestoreDatasourceInterface>();
      final userDataModel =
        await userDataFirestoreDatasource.fetchCustomUserData(customUserId);
      return Left(userDataModel);
    } on Exception catch(exception){
      return Future.value(Right(
          ServerFailure(stackTrace: exception.toString())
      ));
    }
  }

}