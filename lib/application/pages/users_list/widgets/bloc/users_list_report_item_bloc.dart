import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/models/report_model.dart';
import 'package:centinelas_app/domain/usecases/load_report_by_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_list_report_item_state.dart';
part 'users_list_report_item_event.dart';

class UsersListReportItemBloc extends Bloc<UsersListReportItemEvent, UsersListReportItemState>{

  UsersListReportItemBloc({
    required this.loadReportByUserUseCase,
  }) : super (UsersListReportItemLoadingState());

  final LoadReportByUserUseCase loadReportByUserUseCase;

  Future<void> readReportByUser(String uid) async {
    emit(UsersListReportItemLoadingState());
    try{
      final reportByUser = await loadReportByUserUseCase.call(uid);
      if(reportByUser.isRight){
        emit(UsersListReportItemErrorState());
      } else {
        emit(UsersListReportItemLoadedState(reportsList: reportByUser.left));
      }
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('UsersListReportItemBloc: ${exception.toString()}');
    }
  }
}