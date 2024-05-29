import 'unique_id.dart';

class RaceCollection {
  final CollectionId id;
  final String raceCollectionTitle;

  RaceCollection({
    required this.id,
    required this.raceCollectionTitle,
  });

  factory RaceCollection.empty() {
    return RaceCollection(
        id: CollectionId(),
        raceCollectionTitle: '',
    );
  }
}