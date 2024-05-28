import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportsViewLoading extends StatelessWidget {
  const ReportsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator.adaptive()
    );
  }
}
