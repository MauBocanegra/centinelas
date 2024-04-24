import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {

  late final String raceIdString;
  late final String raceNameString;
  late final Map<String, dynamic> raceLog;
  final List<IncidenceModel> incidencesList = [];

  @override
  List<Object> get props => [
    raceIdString,
    raceNameString,
    raceLog,
    incidencesList
  ];
}


