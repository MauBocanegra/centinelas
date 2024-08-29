import 'package:centinelas/data/models/report_model.dart';

abstract class ReportsFirestoreDatasourceInterface {
  Future<List<ReportModel>> fetchRacesReports(String uid);
}