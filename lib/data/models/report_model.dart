import 'package:centinelas/data/models/incidence_model.dart';
import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {

  late final String? raceID;
  late final String? lastInteraction;
  late final bool? activeStatus;
  late final String? title;
  late final Map<String, dynamic> raceLog;
  final List<IncidenceModel> incidencesList = [];

  @override
  List<Object?> get props => [
    raceID,
    lastInteraction,
    activeStatus,
    title,
    raceLog,
    incidencesList
  ];
}


