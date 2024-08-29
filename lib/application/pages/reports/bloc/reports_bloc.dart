import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/data/models/report_model.dart';
import 'package:centinelas/domain/usecases/load_reports_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc({
    required this.loadReportsUseCase
  }) : super (const ReportsLoadingState());
  final LoadUserReportsUseCase loadReportsUseCase;

  Future<void> readUserReports() async {
    emit(const ReportsLoadingState());
    try{
      final fullReport = await loadReportsUseCase.call(NoParams());
      if(fullReport.isRight){
        emit(const ReportsErrorState());
      } else {
        emit(ReportsLoadedState(reportsList: fullReport.left));
      }
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('ReportsBloc: ${exception.toString()}');
    }
  }
}