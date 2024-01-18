import 'package:centinelas_app/data/models/race_collection_model.dart';

abstract class RacesRemoteDateSourceInterface {
  Future<List<RaceCollectionModel>> fetchRaceCollections();
}