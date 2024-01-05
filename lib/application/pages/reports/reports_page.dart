import 'package:flutter/material.dart';

import '../../core/page_config.dart';
import '../../core/routes_constants.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.area_chart,
    name: reportsRoute,
    child: ReportsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}
