import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';

abstract class WriteEngagementRaceFirestoreDatasourceInterface {
  Future<bool> writeRaceEngagement(
    String raceId,
    RaceEngagementRequestType engagementType,
  );
}