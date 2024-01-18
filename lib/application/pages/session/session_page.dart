import 'package:centinelas_app/application/app/bloc/auth_cubit.dart' as auth;
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/home/home_page.dart';
import 'package:centinelas_app/application/pages/login/login_page.dart';
import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:centinelas_app/application/widgets/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

import '../../core/page_config.dart';
import '../../core/routes_constants.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});
  static const pageConfig = PageConfig(
    icon: Icons.image,
    name: sessionRoute,
  );

  @override
  State<StatefulWidget> createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if(serviceLocator<FirebaseAuth>().currentUser != null){
        debugPrint('shouldGoToHome');
        context.goNamed(
          HomePage.pageConfig.name,
          pathParameters: {'tab' : RacesPage.pageConfig.name},
        );
      } else {
        debugPrint('shouldGoToLogin');
        context.go('/${LoginPage.pageConfig.name}');
      }
    });
    return Container(
        color: primaryColorRed,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
