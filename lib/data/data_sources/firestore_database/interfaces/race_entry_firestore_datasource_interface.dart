import 'package:centinelas/data/models/race_entry_model.dart';

abstract class RaceEntryFirestoreDatasourceInterface {
  Future<RaceEntryModel> fetchRaceEntry(String raceEntryId);
}