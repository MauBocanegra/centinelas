import 'dart:async';

import 'package:centinelas_app/data/models/incidence_model.dart';

abstract class RealtimeRepository{
  Future<bool> writeIncidenceInRealtimeDB(Map<String, dynamic> data);
  StreamController<Iterable<IncidenceModel>> getIncidenceModelStream();
}