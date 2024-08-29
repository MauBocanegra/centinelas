import 'dart:convert';
import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/data/models/incidence_model.dart';
import 'package:centinelas/data/models/report_model.dart';
import 'package:http/http.dart';

List<ReportModel> mapReportDataToReportModel(Response response){
  if(response.statusCode == 200){
    var decodedBody = jsonDecode(response.body);

    String message = decodedBody['message'];

    if(message == 'OK'){
      List<dynamic> data = decodedBody['data'];
      List<ReportModel> reports = [];
      for (var eachRace in data) {
        ReportModel reportModel = ReportModel();
        reportModel.raceID = eachRace['race_id'];
        reportModel.title = eachRace['titulo'];
        reportModel.lastInteraction = eachRace['last_interaction'];
        reportModel.activeStatus = eachRace['esta_activa'];
        reportModel.raceLog = eachRace['race_log'];
        List<dynamic> incidencesData = eachRace['incidences'];
        for(var eachIncidence in incidencesData){
          IncidenceModel incidenceModel = IncidenceModel(
              raceId: eachIncidence[raceIdRealtimeDBKey],
              centinelId: eachIncidence[centinelIdRealtimeDBKey],
              time: eachIncidence[incidenceTimeRealtimeDBKey],
              text: eachIncidence[incidenceTextRealtimeDBKey],
              type: eachIncidence[incidenceTypeRealtimeDBKey],
              lat: eachIncidence[incidenceLatitudeRealtimeDBKey],
              lon: eachIncidence[incidenceLongitudeRealtimeDBKey],
          );
          reportModel.incidencesList.add(incidenceModel);
        }
        reports.add(reportModel);
      }
      return reports;
    } else {
      return [];
    }
  } else {
    return [];
  }
}
