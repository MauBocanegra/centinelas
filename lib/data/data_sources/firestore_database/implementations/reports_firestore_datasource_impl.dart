import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/reports_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/mappers/report_data_to_report_model_mapper.dart';
import 'package:centinelas_app/data/models/report_model.dart';
import 'package:centinelas_app/domain/utils/user_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportsFirestoreDatasource implements ReportsFirestoreDatasourceInterface{

  final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
  final FirebaseDatabase firebase = serviceLocator<FirebaseDatabase>();

  late final ReportModel reportModel;

  @override
  Future<List<ReportModel>> fetchRacesReports(String uid) async {
    try{
      Uri uri = Uri.https(
          'us-central1-centinelas-27d9b.cloudfunctions.net',
          'app/api/prod/reports/$uid'
      );
      http.Response response = await http.get(uri);
      return mapReportDataToReportModel(response);
    } on Exception catch(e){
      serviceLocator<FirebaseCrashlytics>().recordError(e, null);
      debugPrint('exception ReportsDataSource: ${e.toString()}');
      return [];
    }
  }
}
