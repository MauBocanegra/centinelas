import 'package:centinelas_app/data/models/race_entry_model.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';

RaceEntry mapRaceEntryModelToRaceEntry(RaceEntryModel raceEntryModel){
  return RaceEntry(
      raceEntryModel.imageUrl,
      title: raceEntryModel.title,
      id: RaceEntryId.fromUniqueString(raceEntryModel.raceEntryId),
      description: raceEntryModel.shortDescription,
  );
}