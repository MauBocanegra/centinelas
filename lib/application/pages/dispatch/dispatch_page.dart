import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/incidences/incidence_page.dart';
import 'package:centinelas/application/pages/login/login_page.dart';
import 'package:centinelas/application/pages/users_list/users_list.page.dart';
import 'package:centinelas/application/utils/color_utils.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/usecases/write_dispatcher_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class DispatchPage extends StatefulWidget {
  final String raceId;
  final String route;
  final String points;
  const DispatchPage({
    super.key,
    required this.raceId,
    required this.route,
    required this.points,
  });

  static const pageConfig = PageConfig(
      icon: Icons.home,
      name: dispatchRoute,
  );

  static const tabs = [
    IncidencesPageProvider.pageConfig,
    UsersListPage.pageConfig,
  ];

  @override
  State<DispatchPage> createState() => DispatchPageState();
}

class DispatchPageState extends State<DispatchPage> {

  static const int incidencesIndex = 0;
  static const int usersListIndex = 1;
  int selectedTab = incidencesIndex;

  changeTab(int selectedIndex){
    setState(() {
      selectedTab = selectedIndex;
    });
  }

  void checkNotifsPermissions() async {
    NotificationSettings settings =
    await serviceLocator<FirebaseMessaging>().requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if(serviceLocator<FirebaseAuth>().currentUser != null){
        try{
          checkNotifsPermissions();
          final writeDispatcherUseCase =
          serviceLocator<WriteDispatcherUseCase>();
          final dispatcherWasWritten =
          await writeDispatcherUseCase.call(NoParams());
          if(dispatcherWasWritten.isRight){
            throw Exception('Unable to write dispatcher in RTDB');
          }
        }on Exception catch(e){
          serviceLocator<FirebaseCrashlytics>().recordError(e, null);
          debugPrint('error inSessionPage ${e.toString()}');
        }
      } else {
        debugPrint('shouldGoToLogin');
        context.go('/${LoginPageProvider.pageConfig.name}');
      }
    });

    List pages = [
      IncidencesPageProvider(
        raceId: widget.raceId,
        route: widget.route,
        points: widget.points,
      ),
      const UsersListPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        surfaceTintColor: Colors.white,
        titleSpacing: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/header_dispatchers.png',
              fit: BoxFit.fitWidth,
              height: 45,
            ),
          ],
        ),
        /*
        actions: <Widget>[
          IconButton(
            onPressed: (){
              serviceLocator<FirebaseAnalytics>().logEvent(
                  name: firebaseEventGoToProfile
              );
              context.goNamed(ProfilePageWidgetProvider.pageConfig.name,);
            },
            icon: Icon(ProfilePageWidgetProvider.pageConfig.icon),
          ),
        ],
        */
      ),
      body: pages[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) => changeTab(index),
        selectedItemColor: redColorCentinelas,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(DispatchPage.tabs[incidencesIndex].icon),
              label: DispatchPage.tabs[incidencesIndex].name
          ),
          BottomNavigationBarItem(
              icon: Icon(DispatchPage.tabs[usersListIndex].icon),
              label: DispatchPage.tabs[usersListIndex].name
          ),
        ],
      ),
    );
  }
}
