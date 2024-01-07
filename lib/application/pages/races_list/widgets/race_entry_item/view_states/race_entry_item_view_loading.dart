import 'package:flutter/material.dart';

class RaceEntryItemViewLoading extends StatelessWidget {
  const RaceEntryItemViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(8.0)
        ),
        child: ListTile(
          leading: Icon(
            Icons.access_time_sharp,
            color:Colors.grey.shade400 ,
          ),
          title: const Text(''),
          subtitle: const Text(''),
        ),
      ),
    );
  }
}
