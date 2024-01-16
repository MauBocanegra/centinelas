import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/races_list/bloc_full/races_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/view_states_full/races_view_error.dart';
import 'package:centinelas_app/application/pages/races_list/view_states_full/races_view_loaded.dart';
import 'package:centinelas_app/application/pages/races_list/view_states_full/races_view_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RacesProvider extends StatelessWidget {
  const RacesProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RacesBloc>(
      create: (context) => serviceLocator<RacesBloc>()..readRaces(),
      child: const RacesPage(),
    );
  }
}

class RacesPage extends StatelessWidget {
  const RacesPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.list,
    name: racesRoute,
    child: RacesProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RacesBloc, RacesState>(
        builder: (context, state) {
      if (state is RacesLoadingState) {
        return const RacesViewLoading();
      } else if (state is RacesLoadedState) {
        return RacesViewLoaded(
            collectionId: state.racesIdsAndRaceCollection.collectionId,
            raceEntryIds: state.racesIdsAndRaceCollection.raceEntryIds
        );
      } else {
        return const RacesViewError();
      }
    });
  }
}
