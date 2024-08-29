import 'package:centinelas/data/models/race_collection_model.dart';
import 'package:centinelas/domain/entities/unique_id.dart';

List<RaceEntryId> mapRaceEntriesIdsModelToRaceEntryIdList(
  RaceEntriesIdsModel raceEntryIdsModel
){
  return raceEntryIdsModel.raceEntryIds.map(
          (raceEntryIdString) => RaceEntryId.fromUniqueString(raceEntryIdString)
  ).toList();
}