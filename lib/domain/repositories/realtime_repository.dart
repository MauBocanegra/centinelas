import 'dart:async';

import 'package:centinelas/data/models/incidence_model.dart';

abstract class RealtimeRepository{
  Future<bool> writeDispatcherInRealtimeDB();
  Future<bool> writeIncidenceInRealtimeDB(Map<String, dynamic> data);
  StreamController<Iterable<IncidenceModel>> getIncidenceModelStream(String raceId);
}