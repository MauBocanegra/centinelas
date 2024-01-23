import 'package:equatable/equatable.dart';

class RaceFullModel extends Equatable {
  final String raceId;
  final String title;
  final String discipline;
  final String address;
  final String description;
  final String imageUrl;
  late final bool isRegistered;
  late final bool isCheckedIn;

  RaceFullModel({
    required this.raceId,
    required this.title,
    required this.discipline,
    required this.address,
    required this.description,
    required this.imageUrl,
  });

  factory RaceFullModel.withNoUserData(
    String raceId,
    String title,
    String discipline,
    String address,
    String description,
    String imageUrl,
  ){
    return RaceFullModel(
        raceId: raceId,
        title: title,
        discipline: discipline,
        address: address,
        description: description,
        imageUrl: imageUrl
    );
  }

  factory RaceFullModel.empty(){
    return RaceFullModel(
        raceId: '', title: '', discipline: '', address: '', description: '', imageUrl: ''
    );
  }

  @override
  List<Object?> get props => [raceId];
}