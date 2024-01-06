import 'package:flutter/material.dart';

class RacesViewLoading extends StatelessWidget {
  const RacesViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
