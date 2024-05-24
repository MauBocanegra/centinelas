import 'package:equatable/equatable.dart';

import 'unique_id.dart';

class RaceFull extends Equatable {
  final RaceEntryId id;
  final String title;
  final String discipline;
  final String address;
  final String description;
  final String imageUrl;
  final String logoUrl;
  final String dayString;
  final String dateString;
  final String hourString;
  final bool isRaceActive;
  final RaceEngagementState raceEngagementState;
  final String raceRoute;
  final Map<dynamic, dynamic> racePoints;

  const RaceFull({
    required this.title,
    required this.discipline,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.id,
    required this.isRaceActive,
    required this.raceEngagementState,
    required this.raceRoute,
    required this.racePoints,
    required this.logoUrl,
    required this.dayString,
    required this.dateString,
    required this.hourString,
  });

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
    logoUrl,
    dayString,
    dateString,
    hourString,
  ];
}

sealed class RaceEngagementState{}
class EmptyEngagementState extends RaceEngagementState{}
class RegisteredEngagementState extends RaceEngagementState{}
class CheckedInEngagementState extends RaceEngagementState{}
