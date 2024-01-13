import 'package:centinelas_app/application/widgets/colors.dart';
import 'package:flutter/material.dart';

import '../../core/page_config.dart';
import '../../core/routes_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.image,
      name: splashRoute,
      child: SplashPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(color: primaryColorRed);
  }
}
