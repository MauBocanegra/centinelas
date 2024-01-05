import 'package:equatable/equatable.dart';

import 'unique_id.dart';

class RaceEntry extends Equatable{
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

  @override
  // TODO: implement props
  List<Object?> get props => [id, description];
}