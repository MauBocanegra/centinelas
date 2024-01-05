import 'package:flutter/material.dart';

class RaceDetailViewLoading extends StatelessWidget {
  const RaceDetailViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}