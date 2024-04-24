import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/reports/bloc/reports_bloc.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_error.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_loaded.dart';
import 'package:centinelas_app/application/pages/reports/view_states/reports_view_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsPageProvider extends StatelessWidget{
  const ReportsPageProvider({ super.key });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsBloc>(
        create: (context) => serviceLocator<ReportsBloc>()
          ..readUserReports(),
        child: const ReportsPage(),
    );
  }
}

class ReportsPage extends StatelessWidget{
  const ReportsPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.area_chart,
    name: reportsRoute,
    child: ReportsPageProvider(),
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
