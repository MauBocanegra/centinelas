import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';

abstract class UsersRepository{
  Future<bool> writeLoggedUserInFirestore(String uid);
  Future<bool> writeRaceEngagementInFirestore(
    String raceId,
    RaceEngagementRequestType engagementType,
  );
}