import 'package:flutter/material.dart';

class RaceDetailViewError extends StatelessWidget {
  const RaceDetailViewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('No se pudo cargar la carrera'),
    );
  }
}