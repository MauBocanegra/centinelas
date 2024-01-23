import 'package:equatable/equatable.dart';

import 'unique_id.dart';

class RaceEntry extends Equatable{
  final String title;
  final String description;
  final RaceEntryId id;
  final String? imageUrl;

  const RaceEntry(this.imageUrl, {
    required this.title,
    required this.id,
    required this.description,
  });

  factory RaceEntry.empty(){
    return RaceEntry(
        '',
        title: '',
        id: RaceEntryId(),
        description: 'Lorem ipsum description'
    );
  }

  @override
  List<Object?> get props => [id, description, imageUrl, title];
}