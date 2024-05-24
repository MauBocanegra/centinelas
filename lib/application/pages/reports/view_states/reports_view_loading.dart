import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportsViewLoading extends StatelessWidget {
  const ReportsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Expanded(
            child: Center(
                child: CircularProgressIndicator.adaptive()
            )
        )
      ],
    );
  }
}
