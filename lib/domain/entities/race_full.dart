import 'package:equatable/equatable.dart';

import 'unique_id.dart';

class RaceFull extends Equatable {
  final RaceEntryId id;
  final String? title;
  final String? discipline;
  final String? address;
  final String? description;
  final String? imageUrl;
  final bool isRaceActive;
  final RaceEngagementState raceEngagementState;
  final String? raceRoute;
  final Map<dynamic, dynamic> racePoints;

  const RaceFull(
      this.title,
      this.discipline,
      this.address,
      this.description,
      this.imageUrl,
      {
        required this.id,
        required this.isRaceActive,
        required this.raceEngagementState,
        required this.raceRoute,
        required this.racePoints,
      }
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    discipline,
    address,
    description,
    imageUrl,
    isRaceActive,
    raceEngagementState,
    raceRoute,
    racePoints,
  ];
}

sealed class RaceEngagementState{}
class EmptyEngagementState extends RaceEngagementState{}
class RegisteredEngagementState extends RaceEngagementState{}
class CheckedInEngagementState extends RaceEngagementState{}
