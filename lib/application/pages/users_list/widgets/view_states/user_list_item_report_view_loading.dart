import 'package:flutter/material.dart';

class UserListItemReportLoadingView extends StatelessWidget {
  const UserListItemReportLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
