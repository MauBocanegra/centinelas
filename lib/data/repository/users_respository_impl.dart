import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/interfaces/register_race_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/user_id_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository{

  UsersRepositoryImpl();

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
}