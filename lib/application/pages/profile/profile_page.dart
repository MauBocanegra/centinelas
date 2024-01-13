import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.person_2_rounded,
    name: profileRoute,
    child: ProfilePage(),
  );

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
