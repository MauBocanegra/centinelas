import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable{

  late final String? phone;
  late final String? emergencyContactName;
  late final String? emergencyContactPhone;
  late final String? severeAllergies;
  late final String? drugSensitivities;

  @override
  List<Object?> get props => [
    phone,
    emergencyContactName,
    emergencyContactPhone,
    severeAllergies,
    drugSensitivities,
  ];

}