import 'package:equatable/equatable.dart';

import 'unique_id.dart';

class RaceEntry extends Equatable{
  final String title;
  final String description;
  final RaceEntryId id;
  final String? imageUrl;
  final String dayString;
  final String dateString;
  final String hourString;

  const RaceEntry(this.imageUrl, {
    required this.title,
    required this.id,
    required this.description,
    required this.dayString,
    required this.dateString,
    required this.hourString,
  });

  @override
  List<Object?> get props => [
    id,
    description,
    imageUrl,
    title,
    dayString,
    dateString,
    hourString
  ];
}