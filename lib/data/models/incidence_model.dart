import 'package:centinelas/application/core/constants.dart';
import 'package:equatable/equatable.dart';

class IncidenceModel extends Equatable{
  final String raceId;
  final String centinelId;
  final String time;
  final String text;
  final String type;
  final double lat;
  final double lon;
  String? phoneNumber;

  IncidenceModel({
    required this.raceId,
    required this.centinelId,
    required this.time,
    required this.text,
    required this.type,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [raceId, centinelId, time, text, type, lat, lon];

  bool isEmergencyType(){
    return type == incidenceEmergencyTypeForMapping;
  }
}