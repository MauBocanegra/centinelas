import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/bloc/race_entry_item_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/view_states/race_entry_item_view_error.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/view_states/race_entry_item_view_loaded.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/view_states/race_entry_item_view_loading.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:centinelas_app/domain/usecases/load_race_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RaceEntryItemProvider extends StatelessWidget {
  const RaceEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.raceEntryId
  });

  final CollectionId collectionId;
  final RaceEntryId raceEntryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceEntryItemBloc>(
      create: (context) => RaceEntryItemBloc(
          loadRaceEntry: LoadRaceEntry(
              raceRepository: RepositoryProvider.of<RacesRepository>(context),
          ),
          raceEntryId: raceEntryId,
          collectionId: collectionId
      )..fetch(),
      child: const RaceEntryItem(),
    );
  }
}


class RaceEntryItem extends StatelessWidget {
  const RaceEntryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaceEntryItemBloc, RaceEntryItemState>(
        builder: (context, state){
          if(state is RaceEntryItemLoadingState){
            return RaceEntryItemViewLoading();
          } else if(state is RaceEntryItemLoadedState) {
            return RaceEntryItemViewLoaded(
              raceEntry: state.raceEntry,
            );
          } else {
            return RaceEntryItemViewError();
          }
        },
    );
  }
}
