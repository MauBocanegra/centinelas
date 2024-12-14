import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/domain/entities/user_data_model.dart';

UserDataModel userDataDocToUserDataModel(Map<String, dynamic> data){
  final UserDataModel userDataModel = UserDataModel();

  userDataModel.phone = data[userDataPhoneKey];
  userDataModel.emergencyContactName = data[userDataEmergencyContactNameKey];
  userDataModel.emergencyContactPhone = data[userDataEmergencyContactPhoneKey];
  userDataModel.severeAllergies = data[userDataSevereAllergiesKey];
  userDataModel.drugSensitivities = data[userDataDrugSensitivitiesKey];
  userDataModel.isAccountDeletionProgrammed = data[userDataAccountDeletionKey];

  return userDataModel;
}