import 'package:flutter/material.dart';

class IncidenceEntryItemViewError extends StatelessWidget {
  const IncidenceEntryItemViewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      onTap: null,
      leading: Icon(Icons.warning_amber_rounded),
      title: Text('No se pudo cargar la incidencia'),
    );
  }
}