import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';

class RaceDetailViewLoaded extends StatelessWidget {
  const RaceDetailViewLoaded({
    super.key,
    required this.collectionId,
    required this.raceEntryIds,
  });

  final List<RaceEntryId> raceEntryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: raceEntryIds.length,
            itemBuilder: (context, item) => const Text('index'),
          ),
        ),
    );
  }
}