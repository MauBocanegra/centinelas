import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/data/models/report_model.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/reports_repository.dart';
import 'package:centinelas_app/domain/utils/user_utils.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class LoadUserReportsUseCase implements UseCase<List<ReportModel>, NoParams>{

  const LoadUserReportsUseCase({required this.reportsRepository});
  final ReportsRepository reportsRepository;

  @override
  Future<Either<List<ReportModel>, Failure>> call(NoParams params) async {
    try{
      final reportsList = reportsRepository.readUserReports(getUserId() ?? '');
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