import 'package:centinelas_app/data/models/race_full_model.dart';

abstract class RaceFullFirestoreDatasourceInterface {
  Future<RaceFullModel> fetchRaceFull(String raceId);
}