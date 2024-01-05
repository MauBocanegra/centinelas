import 'unique_id.dart';

class RaceEntry {
  final String description;
  final RaceEntryId id;

  const RaceEntry({
    required this.id,
    required this.description,
  });

  factory RaceEntry.empty(){
    return RaceEntry(
        id: RaceEntryId(),
        description: 'Lorem ipsum description'
    );
  }
}