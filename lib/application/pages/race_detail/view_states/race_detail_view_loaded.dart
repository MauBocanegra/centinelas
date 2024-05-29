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
    return SingleChildScrollView(
      reverse: true,
        child: Column(
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
            LayoutBuilder(
              builder: (context, constraints) {
                return Image.network(
                  widget.raceFull.imageUrl,
                  width: constraints.maxWidth/2.75,
                );
              },
            ),
            LayoutBuilder(
                builder: (context, constraints){
                  return Material(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(8.0)
                    ),
                    child: Container(
                      width: constraints.maxWidth/1.4,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image(
                          image: NetworkImage(widget.raceFull.logoUrl),
                          width: constraints.maxWidth/2.5,
                        ),
                      )
                    ),
                  );
                }
            ),
            const SizedBox(height: 16.0,),
            Column(
              children: [
                Text(
                  widget.raceFull.dayString,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: Colors.black54
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  '${widget.raceFull.dateString}\n${widget.raceFull.hourString}',
                  style: const TextStyle(
                      height: 0,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0,),
            RaceDetailsButtonsWidgetProvider(
                raceFull: widget.raceFull,
            ),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
        ),
      );
  }
}