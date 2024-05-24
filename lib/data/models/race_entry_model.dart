import 'package:equatable/equatable.dart';

class RaceEntryModel extends Equatable {
  final String raceEntryId;
  final String title;
  final String shortDescription;
  final String imageUrl;
  final String dayString;
  final String dateString;
  final String hourString;

  const RaceEntryModel({
    required this.raceEntryId,
    required this.title,
    required this.shortDescription,
    required this.imageUrl,
    required this.dayString,
    required this.dateString,
    required this.hourString,
  });

  factory RaceEntryModel.empty(){
    return const RaceEntryModel(
        raceEntryId: '',
        title: '',
        shortDescription: '',
        imageUrl: '',
        dayString: '',
        dateString: '',
        hourString: '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    raceEntryId,
    title,
    shortDescription,
    imageUrl,
    dayString,
    dateString,
    hourString,
  ];
}