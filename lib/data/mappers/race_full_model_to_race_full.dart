import 'package:centinelas_app/data/models/race_full_model.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';

RaceFull mapRaceFullModelToRaceFull(RaceFullModel raceFullModel) {
  return RaceFull(
      raceFullModel.title,
      raceFullModel.discipline,
      raceFullModel.address,
      raceFullModel.description,
      raceFullModel.imageUrl,
      id: RaceEntryId.fromUniqueString(raceFullModel.raceId)
  );
}