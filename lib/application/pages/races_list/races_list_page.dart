import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/load_race_collection.dart';
import '../../core/page_config.dart';
import '../../core/routes_constants.dart';
import 'bloc/races_list_bloc.dart';
import 'view_states/races_list_view_error.dart';
import 'view_states/races_list_view_loaded.dart';
import 'view_states/races_list_view_loading.dart';

class RacesListProvider extends StatelessWidget {
  const RacesListProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RacesListBloc>(
        create: (context){
          return RacesListBloc(
            loadRaceCollectionsUseCase: LoadRaceCollectionsUseCase(
                racesRepository: RepositoryProvider.of(context),
            )
          )..readRacesCollections();
        },
      child: const RacesListPage(),
    );
  }
}


class RacesListPage extends StatelessWidget {
  const RacesListPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.list,
    name: racesListRoute,
    child: RacesListProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      child: BlocBuilder<RacesListBloc, RacesListState>(
        builder: (context, state) {
          if(state is RacesListLoadingState){
            return const RacesListViewLoading();
          } else if (state is RacesListLoadedState) {
            return RacesListViewLoaded(collections: state.collections);
          } else {
            return const RacesListViewError();
          }
        },
      ),
    );
  }
}
