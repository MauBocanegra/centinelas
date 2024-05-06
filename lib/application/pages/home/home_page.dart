import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/profile/profile_page.dart';
import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:centinelas_app/application/pages/reports/reports_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static const pageConfig = PageConfig(
    icon: Icons.home,
    name: homeRoute,
  );

  static const tabs = [
    RacesPage.pageConfig,
    ReportsPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  static const int racesIndex = 0;
  static const int reportsIndex = 1;
  int selectedTab = racesIndex;

  changeTab(int selectedIndex){
    setState(() {
      selectedTab = selectedIndex;
    });
  }

  List pages = [
    const RacesProvider(),
    const ReportsPageProvider(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centinelas'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              serviceLocator<FirebaseAnalytics>().logEvent(
                  name: firebaseEventGoToProfile
              );
              context.goNamed(ProfilePageWidgetProvider.pageConfig.name,);
            },
            icon: Icon(ProfilePageWidgetProvider.pageConfig.icon),
          )
        ],
      ),
      body: pages[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (index) => changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(HomePage.tabs[racesIndex].icon),
              label: HomePage.tabs[racesIndex].name
          ),
          BottomNavigationBarItem(
              icon: Icon(HomePage.tabs[reportsIndex].icon),
              label: HomePage.tabs[reportsIndex].name
          ),
        ],
      ),
    );
  }
}
