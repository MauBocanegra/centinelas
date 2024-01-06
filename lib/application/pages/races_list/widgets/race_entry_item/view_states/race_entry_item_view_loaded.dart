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
    return ListTile(
      title: Text(raceEntry.id.value),
      subtitle: Text(raceEntry.description),
      leading: Icon(Icons.directions_run_rounded),
    );
  }
}
