import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/firestore_database/interfaces/reports_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/models/report_model.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/reports_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ReportsRepositoryImpl extends ReportsRepository {
  ReportsRepositoryImpl();

  @override
  Future<Either<List<ReportModel>, Failure>> readUserReports() async {
    try{
      final reportsFirestoreDatasource =
          serviceLocator<ReportsFirestoreDatasourceInterface>();
      final reportsDataModel =
          await reportsFirestoreDatasource.fetchRacesReports();
      return Left(reportsDataModel);
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Future.value(
          Right(ServerFailure(
              stackTrace: exception.toString()
          ))
      );
    }
  }

}