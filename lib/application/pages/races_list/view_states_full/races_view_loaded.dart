import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/race_entry_item.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';

class RacesViewLoaded extends StatelessWidget {
  const RacesViewLoaded({
    super.key,
    required this.raceEntryIds,
  });

  final List<RaceEntryId> raceEntryIds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: raceEntryIds.length,
      itemBuilder: (context, index) => RaceEntryItemProvider(
          raceEntryId: raceEntryIds[index]
      ),
    );
  }
}
