import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_loaded.dart';
import 'package:centinelas_app/application/pages/users_list/widgets/bloc/users_list_report_item_bloc.dart';
import 'package:centinelas_app/application/pages/users_list/widgets/view_states/user_list_item_report_view_error.dart';
import 'package:centinelas_app/application/pages/users_list/widgets/view_states/user_list_item_report_view_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListItemReportViewLoaded extends StatelessWidget {
  const UsersListItemReportViewLoaded({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersListReportItemBloc>(
      create: (context) => serviceLocator<UsersListReportItemBloc>()
        ..readReportByUser(uid),
      child: const UsersListItemReportViewLoadedProvided(),
    );
  }
}

class UsersListItemReportViewLoadedProvided extends StatelessWidget {
  const UsersListItemReportViewLoadedProvided({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersListReportItemBloc, UsersListReportItemState>(
      builder: (context, state){
        if(state is UsersListReportItemLoadingState){
          return const UserListItemReportLoadingView();
        } else if ( state is UsersListReportItemLoadedState){
          return ReportsViewLoaded(
              reportsModelList: state.reportsList
          );
        } else {
          return const UserListItemReportErrorView();
        }
      },
    );
  }
}


