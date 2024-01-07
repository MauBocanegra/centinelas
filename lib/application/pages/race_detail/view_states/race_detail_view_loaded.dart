import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:flutter/material.dart';

class RaceDetailViewLoaded extends StatelessWidget {
  const RaceDetailViewLoaded({
    super.key,
    required this.raceFull
  });

  final RaceFull raceFull;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text('Race ${raceFull.id.value} detail'))
        ),
    );
  }
}