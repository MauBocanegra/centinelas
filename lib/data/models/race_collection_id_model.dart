import 'package:equatable/equatable.dart';

class RaceCollectionIdModel extends Equatable {
  final String raceCollectionId;

  const RaceCollectionIdModel({ required this.raceCollectionId, });

  @override
  List<Object?> get props => [raceCollectionId];
}