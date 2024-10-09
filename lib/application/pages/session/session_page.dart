import 'dart:convert';

import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/dispatch/dispatch_page.dart';
import 'package:centinelas/application/pages/home/home_page.dart';
import 'package:centinelas/application/pages/login/login_page.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/usecases/dispatch_clearance_and_active_race_usecase.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class SessionPageProvider extends StatefulWidget {
  const SessionPageProvider({super.key});
  static const pageConfig = PageConfig(
    icon: Icons.image,
    name: sessionRoute,
  );

  @override
  State<StatefulWidget> createState() => SessionPageState();
}

class SessionPageState extends State<SessionPageProvider> {

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if(serviceLocator<FirebaseAuth>().currentUser != null) {
        try {
          final dispatchClearanceAndActiveRaceUseCase =
            serviceLocator<DispatchClearanceAndActiveRaceUseCase>();

          final clearanceAndActiveRaceResult =
            await dispatchClearanceAndActiveRaceUseCase.call(NoParams());
          late final Map<dynamic, dynamic> activeRaceData;
          clearanceAndActiveRaceResult.fold(
                (fetchedRaceData) {
              activeRaceData = fetchedRaceData;
            },
                (right) => activeRaceData = {},
          );
          if (context.mounted) {
            if ((activeRaceData[raceEntryIdKey] ?? '').isNotEmpty) {
              serviceLocator<FirebaseAnalytics>().logEvent(
                  name: firebaseEventGoToDispatch
              );
              context.goNamed(
                DispatchPage.pageConfig.name,
                extra: {
                  raceGoogleMapRouteKey: activeRaceData[raceGoogleMapRouteKey],
                  raceGoogleMapPointsKey: json.encode(activeRaceData[raceGoogleMapPointsKey]),
                  raceEntryIdKey : activeRaceData[raceEntryIdKey],
                }
              );
            } else {
              context.goNamed(HomePage.pageConfig.name);
            }
          }
        }on Exception catch(exception){
          serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
          debugPrint('error inSessionPage ${exception.toString()}');
        }
      } else {
        context.go('/${LoginPageProvider.pageConfig.name}');
      }
    });
    return Container(
        color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
