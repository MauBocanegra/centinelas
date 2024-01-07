import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:flutter/material.dart';

class RaceEntryItemViewLoaded extends StatelessWidget {
  const RaceEntryItemViewLoaded({
    super.key,
    required this.raceEntry,
  });

  final RaceEntry raceEntry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0)),
        child: ListTile(
          title: Text(raceEntry.id.value),
          subtitle: Text(raceEntry.description),
          leading: const Icon(Icons.directions_run_rounded),
        ),
      ),
    );
  }
}
