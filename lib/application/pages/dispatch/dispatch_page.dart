import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/pages/incidences/incidence_page.dart';
import 'package:centinelas_app/application/pages/reports/reports_page.dart';
import 'package:centinelas_app/application/pages/users_list/users_list.page.dart';
import 'package:flutter/material.dart';

class DispatchPage extends StatefulWidget {
  const DispatchPage({super.key});

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

  List pages = [
    IncidencesPageProvider(),
    const UsersListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despachador'),
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
        selectedItemColor: Colors.red,
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
