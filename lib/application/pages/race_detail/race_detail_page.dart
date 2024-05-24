import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/home/home_page.dart';
import 'package:centinelas_app/application/pages/race_detail/bloc/race_detail_bloc.dart';
import 'package:centinelas_app/application/pages/race_detail/view_states/race_detail_view_error.dart';
import 'package:centinelas_app/application/pages/race_detail/view_states/race_detail_view_loaded.dart';
import 'package:centinelas_app/application/pages/race_detail/view_states/race_detail_view_loading.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RaceDetailPageProvider extends StatelessWidget {

  RaceDetailPageProvider({
    super.key,
    required String raceEntryIdString,
  }): raceEntryId = RaceEntryId.fromUniqueString(raceEntryIdString);

  final RaceEntryId raceEntryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceDetailBloc>(
      create: (context) => serviceLocator<RaceDetailBloc>()
        ..readRaceFull(raceEntryId),
      child: RaceDetailPage(
        raceEntryId: raceEntryId,
      ),
    );
  }
}

class RaceDetailPage extends StatelessWidget {
  const RaceDetailPage({
    super.key,
    required this.raceEntryId
  });
  final RaceEntryId raceEntryId;

  static const pageConfig = PageConfig(
    icon: Icons.stadium_outlined,
    name: raceDetailRoute,
    child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/header_carrera.png',
          fit: BoxFit.contain,
          height: 32,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: (){
            if(context.canPop()){
              context.pop();
            } else {
              context.goNamed(
                HomePage.pageConfig.name,
              );
            }
          },
        ),
      ),
      body: BlocBuilder<RaceDetailBloc, RaceDetailState>(
        builder: (context, state){
          if(state is RaceDetailLoadingState){
            return const RaceDetailViewLoading();
          } else if(state is RaceDetailLoadedState){
            return RaceDetailViewLoaded(raceFull: state.raceFull);
          } else {
            return const RaceDetailViewError();
          }
        }
      ),
    );
  }
}
