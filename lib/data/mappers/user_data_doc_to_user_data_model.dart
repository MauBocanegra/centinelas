import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/domain/entities/user_data_model.dart';

UserDataModel userDataDocToUserDataModel(Map<String, dynamic> data){
  final UserDataModel userDataModel = UserDataModel();

  userDataModel.phone = data[userDataPhoneKey];

  return userDataModel;
}