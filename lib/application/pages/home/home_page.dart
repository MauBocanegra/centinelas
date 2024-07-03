import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/profile/profile_page.dart';
import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:centinelas_app/application/pages/reports/reports_page.dart';
import 'package:centinelas_app/application/utils/color_utils.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/usecases/write_user_id_usecase.dart';
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
    ReportPage.pageConfig,
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
    const ReportPageProvider(),
  ];

  @override
  void initState() {
    super.initState();
    serviceLocator<WriteUserIdUseCase>().call(NoParams());
  }

  @override
  Widget build(BuildContext context) {
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
              'assets/header_centinelas.png',
              fit: BoxFit.fitWidth,
              height: 35,
            ),
          ],
        ),
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
        selectedItemColor: redColorCentinelas,
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
