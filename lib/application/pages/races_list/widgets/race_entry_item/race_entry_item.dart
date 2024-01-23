import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/bloc/race_entry_item_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/view_states/race_entry_item_view_error.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/view_states/race_entry_item_view_loaded.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/view_states/race_entry_item_view_loading.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RaceEntryItemProvider extends StatelessWidget {
  const RaceEntryItemProvider({
    super.key,
    required this.raceEntryId
  });

  final RaceEntryId raceEntryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceEntryItemBloc>(
      create: (context) => serviceLocator<RaceEntryItemBloc>()
        ..readRaceEntryItem(raceEntryId),
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
