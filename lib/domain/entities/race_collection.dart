import 'race_color.dart';
import 'unique_id.dart';

class RaceCollection {
  final CollectionId id;
  final String title;
  final RaceColor color;

  RaceCollection({
    required this.id,
    required this.title,
    required this.color,
  });

  factory RaceCollection.empty() {
    return RaceCollection(
        id: CollectionId(),
        title: '',
        color: RaceColor(colorIndex: 0,),
    );
  }
}