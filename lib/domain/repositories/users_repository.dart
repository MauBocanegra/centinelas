import 'package:centinelas/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas/domain/entities/user_data_model.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class UsersRepository{
  Future<bool> writeDispatcherInRealtimeDatabase();
  Future<bool> writeLoggedUserInFirestore();
  Future<bool> writeRaceEngagementInFirestore(
    String raceId,
    RaceEngagementRequestType engagementType,
  );
  Future<Either<UserDataModel,Failure>> readUserData();
  Future<Either<UserDataModel,Failure>> readCustomUserData(
    String customUserId
  );
  Future<bool> updateUserData(UserDataModel data);
  Future<bool> isCurrentUserDispatchAuthorized();
  Future<Either<List<String>, Failure>> readUsersList();
}