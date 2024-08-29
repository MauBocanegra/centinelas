import 'package:centinelas/domain/entities/unique_id.dart';

class RacesIdsAndRaceCollection {
  final CollectionId collectionId;
  final List<RaceEntryId> raceEntryIds;

  RacesIdsAndRaceCollection({
    required this.collectionId,
    required this.raceEntryIds,
  });
}