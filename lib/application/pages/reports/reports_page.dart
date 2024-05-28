import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/reports/bloc/reports_bloc.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_error.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_loaded.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPageProvider extends StatelessWidget{
  const ReportPageProvider({ super.key });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsBloc>(
        create: (context) => serviceLocator<ReportsBloc>()
          ..readUserReports(),
        child: const ReportPage(),
    );
  }
}

class ReportPage extends StatelessWidget{
  const ReportPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.feed_rounded,
    name: reportsRoute,
    child: ReportPageProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state){
          if(state is ReportsLoadingState){
            return const ReportsViewLoading();
          } else if(state is ReportsLoadedState){
            return ReportsViewLoaded(
                reportsModelList: state.reportsList
            );
          } else { // error state
            return const ReportsViewError();
          }
        }
    );
  }

}
