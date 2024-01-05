import 'package:flutter/material.dart';

import '../../core/page_config.dart';
import '../../core/routes_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.login,
    name: loginRoute,
    child: LoginPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.deepOrangeAccent);
  }
}
