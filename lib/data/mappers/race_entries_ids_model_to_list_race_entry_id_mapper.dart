import 'package:centinelas_app/data/models/race_collection_model.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';

List<RaceEntryId> mapRaceEntriesIdsModelToRaceEntryIdList(
  RaceEntriesIdsModel raceEntryIdsModel
){
  return raceEntryIdsModel.raceEntryIds.map(
          (raceEntryIdString) => RaceEntryId.fromUniqueString(raceEntryIdString)
  ).toList();
}