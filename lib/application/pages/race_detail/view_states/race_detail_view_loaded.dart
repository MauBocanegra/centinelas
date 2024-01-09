import 'package:centinelas_app/application/widgets/button_style.dart';
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
                  raceFull.imageUrl ?? 'https://www.zonaturistica.com/files/ferias/995/F4_995.jpg'
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
              ElevatedButton(
                style: raisedBlueButtonStyle,
                onPressed: () { },
                child: Text('Registrarse'),
              ),
              ElevatedButton(
                style: raisedOrangeButtonStyle,
                onPressed: () { },
                child: Text('CheckIn'),
              ),
              ElevatedButton(
                style: raisedYellowButtonStyle,
                onPressed: () { },
                child: Text('Solicitar asistencia'),
              ),
              ElevatedButton(
                style: raisedRedButtonStyle,
                onPressed: () { },
                child: Text('Reportar EMERGENCIA'),
              ),
            ],

          ))
        ),
    );
  }
}