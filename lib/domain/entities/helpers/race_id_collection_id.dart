import 'package:centinelas_app/domain/entities/unique_id.dart';

class RaceIdCollectionId {
  final CollectionId collectionId;
  final RaceEntryId raceEntryId;

  RaceIdCollectionId({
    required this.collectionId,
    required this.raceEntryId,
  });
}