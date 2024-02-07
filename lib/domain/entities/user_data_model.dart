import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable{

  late final String? phone;

  @override
  List<Object?> get props => [phone];

}