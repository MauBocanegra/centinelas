import 'package:equatable/equatable.dart';

class RaceModel extends Equatable {

  final String raceId;
  final String title;
  final String description;

  const RaceModel({
    required this.raceId,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [raceId, title, description];

}