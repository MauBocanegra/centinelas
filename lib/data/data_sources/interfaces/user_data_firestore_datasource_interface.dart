import 'package:centinelas_app/domain/entities/user_data_model.dart';

abstract class UserDataFirestoreDatasourceInterface {
  Future<UserDataModel> fetchUserData();
  Future<bool> updateUserData(UserDataModel userDataModel);
}