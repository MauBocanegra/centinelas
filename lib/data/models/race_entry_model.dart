import 'package:equatable/equatable.dart';

class RaceEntryModel extends Equatable {
  final String raceEntryId;
  final String title;
  final String shortDescription;
  final String imageUrl;

  const RaceEntryModel({
    required this.raceEntryId,
    required this.title,
    required this.shortDescription,
    required this.imageUrl,
  });

  factory RaceEntryModel.empty(){
    return const RaceEntryModel(
        raceEntryId: '',
        title: '',
        shortDescription: '',
        imageUrl: '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    raceEntryId,
    title,
    shortDescription,
    imageUrl
  ];
}