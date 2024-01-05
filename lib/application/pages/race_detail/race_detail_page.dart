import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/pages/race_detail/bloc/race_detail_bloc.dart';
import 'package:centinelas_app/application/pages/race_detail/view_states/race_detail_view_error.dart';
import 'package:centinelas_app/application/pages/race_detail/view_states/race_detail_view_loaded.dart';
import 'package:centinelas_app/application/pages/race_detail/view_states/race_detail_view_loading.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:centinelas_app/domain/usecases/load_race_entry_ids_for_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/page_config.dart';

class RaceDetailPageProvider extends StatelessWidget {
  const RaceDetailPageProvider({
    super.key,
    required this.collectionId
  });

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceDetailBloc>(
      create: (context) => RaceDetailBloc(
          collectionId: collectionId,
          loadRaceEntryIdsForCollection: LoadRaceEntryIdsForCollection(
              racesRepository: RepositoryProvider.of<RacesRepository>(context,),
          )
      )..fetch(),
      child: RaceDetailPage(collectionId: collectionId),
    );
  }
}

class RaceDetailPage extends StatelessWidget {
  const RaceDetailPage({
    super.key,
    required this.collectionId
  });
  final CollectionId collectionId;

  static const pageConfig = PageConfig(
    icon: Icons.stadium_outlined,
    name: raceDetail,
    child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaceDetailBloc, RaceDetailState>(
      builder: (context, state){
        if(state is RaceDetailLoadingState){
          return const RaceDetailViewLoading();
        } else if(state is RaceDetailLoadedState){
          return RaceDetailViewLoaded(
              collectionId: collectionId,
              raceEntryIds: state.raceEntryIds
          );
        } else {
          return const RaceDetailViewError();
        }
      }
    );
  }
}
