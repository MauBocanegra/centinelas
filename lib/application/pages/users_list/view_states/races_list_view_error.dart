import 'package:centinelas_app/application/core/strings.dart';
import 'package:flutter/material.dart';

class RacesListViewError extends StatelessWidget {
  const RacesListViewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text(usersListErrorString),
    );
  }
}
