import 'package:centinelas_app/data/models/race_collection_model.dart';

abstract class RacesEntriesIdsFirestoreDateSourceInterface {
  Future<RaceEntriesIdsModel> fetchRaceEntriesIdsList(String collectionIdToBeDisplayed);
}