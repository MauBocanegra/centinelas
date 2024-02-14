import 'package:centinelas_app/application/pages/race_detail/widgets/widget_race_details_buttons.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:flutter/material.dart';

class RaceDetailViewLoaded extends StatefulWidget {
  const RaceDetailViewLoaded({
    super.key,
    required this.raceFull
  });

  final RaceFull raceFull;

  @override
  State<RaceDetailViewLoaded> createState() => RaceDetailViewLoadedState();
}


class RaceDetailViewLoadedState extends State<RaceDetailViewLoaded> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            reverse: true,
              child: Column(
                children: [
                  Text(
                    widget.raceFull.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Image.network(
                      widget.raceFull.imageUrl ?? ''
                  ),
                  Text(
                    widget.raceFull.address?.replaceAll("\\n", "\n") ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.raceFull.description?.replaceAll("\\n", "\n") ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  RaceDetailsButtonsWidgetProvider(
                      raceFull: widget.raceFull,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            )
          )
    );
  }
}