import 'package:equatable/equatable.dart';

class RaceFullModel extends Equatable {
  final String raceId;
  final String title;
  final String discipline;
  final String address;
  final String description;
  final String imageUrl;
  final String route;
  final Map<dynamic, dynamic> points;

  /// can be 'vacio' || registrada' || 'checkedin' see constants.dart
  late final String raceEngagementState;
  final bool isRaceActive;

  RaceFullModel({
    required this.raceId,
    required this.title,
    required this.discipline,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.isRaceActive,
    required this.points,
    required this.route,
  });

  @override
  List<Object?> get props => [
    raceId,
    title,
    discipline,
    address,
    description,
    imageUrl,
    isRaceActive,
    points,
    route,
  ];
}