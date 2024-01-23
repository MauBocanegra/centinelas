import 'package:equatable/equatable.dart';

class RaceEntriesIdsModel extends Equatable{
  final String raceCollectionId;
  final List<String> raceEntryIds;

  const RaceEntriesIdsModel({
    required this.raceCollectionId,
    required this.raceEntryIds,
  });

  @override
  List<Object?> get props => [raceCollectionId, raceEntryIds];
}