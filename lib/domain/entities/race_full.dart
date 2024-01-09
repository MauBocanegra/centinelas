import 'package:equatable/equatable.dart';

import 'unique_id.dart';

class RaceFull extends Equatable {
  final RaceEntryId id;
  final String? title;
  final String? discipline;
  final String? address;
  final String? description;
  final String? imageUrl;

  const RaceFull(
      this.title,
      this.discipline,
      this.address,
      this.description,
      this.imageUrl,
      {
        required this.id,
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
  ];
}