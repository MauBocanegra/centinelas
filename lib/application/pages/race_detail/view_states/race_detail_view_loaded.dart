import 'package:centinelas_app/application/pages/race_detail/widgets/widget_race_details_buttons.dart';
import 'package:centinelas_app/application/widgets/button_style.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: Center(child: Column(
            children: [
              Text(
                raceFull.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Image.network(
                  raceFull.imageUrl ?? ''
              ),
              Text(
                raceFull.discipline ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                raceFull.address ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                raceFull.description ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              RaceDetailsButtonsWidgetProvider(
                  raceFull: raceFull,
              ),
              const Spacer(),
            ],

          ))
        ),
    );
  }

  bool showEmergencyButton(){
    return raceFull.isRaceActive &&
        raceFull.raceEngagementState is CheckedInEngagementState;
  }

  bool showCheckInButton(){
    return raceFull.raceEngagementState is RegisteredEngagementState;
  }

  bool showRegisterButton(){
    return raceFull.raceEngagementState is EmptyEngagementState;
  }
}