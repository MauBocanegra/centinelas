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
    return Column(
      children: [
        Material(
          elevation: 8,
          child: Container(
            alignment: Alignment.center,
            height: 12,
            child: Container(),
          ),
        ),
        const SizedBox(height: 24,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: raceEntryIds.length,
          itemBuilder: (context, index) => RaceEntryItemProvider(
              raceEntryId: raceEntryIds[index]
          ),
        ),
      ],
    );
  }
}
