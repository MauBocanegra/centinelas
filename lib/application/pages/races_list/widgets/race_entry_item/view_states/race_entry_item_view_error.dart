import 'package:flutter/material.dart';

class RaceEntryItemViewError extends StatelessWidget {
  const RaceEntryItemViewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      onTap: null,
      leading: Icon(Icons.warning_amber_rounded),
      title: Text('No se pudo cargar la carrera'),
    );
  }
}
