import 'package:centinelas_app/application/app/bloc/auth_cubit.dart' as auth;
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/dispatch/dispatch_page.dart';
import 'package:centinelas_app/application/pages/home/home_page.dart';
import 'package:centinelas_app/application/pages/login/login_page.dart';
import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:centinelas_app/application/widgets/colors.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/usecases/dispatch_clearance_and_active_race_usecase.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

import '../../core/page_config.dart';
import '../../core/routes_constants.dart';

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

  //late final BlocProvider

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if(serviceLocator<FirebaseAuth>().currentUser != null) {
        try {
          final dispatchClearanceAndActiveRaceUseCase =
            serviceLocator<DispatchClearanceAndActiveRaceUseCase>();
          /// TODO this is probable am antipattern so this must be refactored
          final clearanceAndActiveRaceResult =
            await dispatchClearanceAndActiveRaceUseCase.call(NoParams());
          late final String activeRace;
          clearanceAndActiveRaceResult.fold(
                (fetchedActiveRace) {
              activeRace = fetchedActiveRace;
            },
                (right) => activeRace = '',
          );
          if (context.mounted) {
            if (activeRace.isNotEmpty) {
              serviceLocator<FirebaseAnalytics>().logEvent(
                  name: firebaseEventGoToDispatch
              );
              context.goNamed(
                DispatchPageProvider.pageConfig.name,
                pathParameters: {activeRaceIdParamKey: activeRace},
              );
            } else {
              context.goNamed(
                HomePage.pageConfig.name,
                pathParameters: {'tab': RacesPage.pageConfig.name},
              );
            }
          }
        }on Exception catch(exception){
          serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
          debugPrint('error inSessionPage ${exception.toString()}');
        }
      } else {
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
