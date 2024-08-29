import 'dart:async';

import 'package:centinelas/data/models/incidence_model.dart';

abstract class IncidenceObserverRealtimeDatasourceInterface {
  StreamController<Iterable<IncidenceModel>>? getIncidenceModelStream(String raceId);
}