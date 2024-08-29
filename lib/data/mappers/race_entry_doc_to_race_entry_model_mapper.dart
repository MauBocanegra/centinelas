import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/data/models/race_entry_model.dart';

/// This mapper will have to add a mechanism to dynamically
/// display whatever is stored in the race entry document
RaceEntryModel mapRaceEntryDocToRaceEntryModel(Map<String, dynamic> map){
  return RaceEntryModel(
      raceEntryId: map[raceEntryIdKey],
      title: map[raceEntryTitleKey],
      shortDescription: map[raceEntryDescriptionKey],
      imageUrl: map[raceEntryLogoKey],
      dayString: map[raceDayLogoKey],
      dateString: map[raceDateLogoKey],
      hourString: map[raceHourLogoKey],
  );
}