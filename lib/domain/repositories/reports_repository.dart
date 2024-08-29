import 'package:centinelas/data/models/report_model.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class ReportsRepository{
  Future<Either<List<ReportModel>, Failure>> readUserReports(String uid);
}