import 'package:centinelas_app/application/core/strings.dart';
import 'package:flutter/material.dart';

class ReportsViewError extends StatefulWidget {
  const ReportsViewError({super.key});

  @override
  State<ReportsViewError> createState() => _ReportsViewErrorState();
}

class _ReportsViewErrorState extends State<ReportsViewError> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(24.0),
      child: Center(
        child: Text(reportsErrorString),
      )
    );
  }
}
