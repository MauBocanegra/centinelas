import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas_app/domain/entities/user_data_model.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class UsersRepository{
  Future<bool> writeLoggedUserInFirestore(String uid);
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
}