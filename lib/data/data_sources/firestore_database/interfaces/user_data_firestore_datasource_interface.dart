import 'package:centinelas/domain/entities/user_data_model.dart';

abstract class UserDataFirestoreDatasourceInterface {
  Future<UserDataModel> fetchUserData();
  Future<UserDataModel> fetchCustomUserData(String userId);
  Future<bool> updateUserData(UserDataModel userDataModel);
  Future<bool> verifyUserHasDispatchClearance();
}