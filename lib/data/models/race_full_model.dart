import 'package:equatable/equatable.dart';

class RaceFullModel extends Equatable {
  final String raceId;
  final String title;
  final String discipline;
  final String address;
  final String description;
  final String imageUrl;

  /// can be 'vacio' || registrada' || 'checkedin' see constants.dart
  late final String raceEngagementState;
  final bool isRaceActive;
  final bool isCheckInEnabled;

  RaceFullModel({
    required this.raceId,
    required this.title,
    required this.discipline,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.isRaceActive,
    required this.isCheckInEnabled,
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
      imageUrl: imageUrl,
      isRaceActive: false,
      isCheckInEnabled: false,
    );
  }

  factory RaceFullModel.empty(){
    return RaceFullModel(
        raceId: '',
        title: '',
        discipline: '',
        address: '',
        description: '',
        imageUrl: '',
        isRaceActive: false,
      isCheckInEnabled: false,
    );
  }

  @override
  List<Object?> get props => [
    raceId,
    title,
    discipline,
    address,
    description,
    imageUrl,
    isRaceActive,
    isCheckInEnabled
  ];
}