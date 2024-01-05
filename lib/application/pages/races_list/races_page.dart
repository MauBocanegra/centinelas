import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/load_race_collection.dart';
import '../../core/page_config.dart';
import '../../core/routes_constants.dart';
import 'bloc/races_list_bloc.dart';
import 'view_states/races_view_error.dart';
import 'view_states/races_view_loaded.dart';
import 'view_states/races_view_loading.dart';

class RacesProvider extends StatelessWidget {
  const RacesProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RacesListBloc>(
        create: (context) => RacesListBloc(
            loadRaceCollectionsUseCase: LoadRaceCollectionsUseCase(
                racesRepository: RepositoryProvider.of(context),
            )
        )..readRacesCollections(),
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
    return Container(
      color: Colors.purpleAccent,
      child: BlocBuilder<RacesListBloc, RacesListState>(
        builder: (context, state) {
          if(state is RacesListLoadingState){
            return const RacesViewLoading();
          } else if (state is RacesListLoadedState) {
            return RacesViewLoaded(collections: state.collections);
          } else {
            return const RacesViewError();
          }
        },
      ),
    );
  }
}
