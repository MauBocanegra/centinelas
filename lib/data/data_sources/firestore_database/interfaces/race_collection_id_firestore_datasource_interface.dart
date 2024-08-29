import 'package:centinelas/data/models/race_collection_id_model.dart';

/// This interfaces fetches the collection ID
/// of the collection the app will display
abstract class RaceCollectionIdFirestoreDatasourceInterface {
  Future<RaceCollectionIdModel> fetchRaceCollectionToDisplayId();
}