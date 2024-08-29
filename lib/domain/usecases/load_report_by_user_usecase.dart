import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/data/models/report_model.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/reports_repository.dart';
import 'package:centinelas/domain/utils/user_utils.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class LoadReportByUserUseCase implements UseCase<List<ReportModel>, String>{
  const LoadReportByUserUseCase({required this.reportsRepository});
  final ReportsRepository reportsRepository;

  @override
  Future<Either<List<ReportModel>, Failure>> call(String uid) async {
    try{
      final reportsList = reportsRepository.readUserReports(formatCustomUID(uid));
      return reportsList.fold(
            (reportsList) => Left(reportsList),
            (failure) => Right(failure),
      );
    } on Exception catch(exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}