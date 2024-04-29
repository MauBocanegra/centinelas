import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/profile/profile_page.dart';
import 'package:centinelas_app/application/pages/race_detail/race_detail_page.dart';
import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:centinelas_app/application/pages/reports/reports_page.dart';
import 'package:centinelas_app/domain/usecases/write_user_id_usecase.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }): index = tabs.indexWhere((element) => element.name == tab);

  static const pageConfig = PageConfig(
    icon: Icons.home,
    name: homeRoute,
  );

  final int index;

  static const tabs = [
    RacesPage.pageConfig,
    ReportsPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final destinations = HomePage.tabs.map(
      (page) => NavigationDestination(
          icon: Icon(page.icon),
          label: page.name,
      )
  ).toList();

  @override
  Widget build(BuildContext context) {
    try {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        final uid = serviceLocator<FirebaseAuth>().currentUser;
        if (uid != null) {
          final writeUserIdUseCase = serviceLocator<WriteUserIdUseCase>();
          await writeUserIdUseCase.call(uid.uid);
        }
      });
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('Unable to write user: ${exception.toString()}');
    }
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  trailing: IconButton(
                      onPressed:(){
                        serviceLocator<FirebaseAnalytics>().logEvent(
                            name: firebaseEventGoToProfile
                        );
                        context.goNamed(ProfilePageWidgetProvider.pageConfig.name,);
                      },
                      icon: Icon((ProfilePageWidgetProvider.pageConfig.icon))
                  ),
                  selectedIndex: widget.index,
                  destinations: destinations.map( (element) =>
                      AdaptiveScaffold.toRailDestination(element)
                  ).toList(),
                  onDestinationSelected: (index) => tapOnNavigationDestination(context, index),
                ),
              )
            },
          ),
          bottomNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                    key: const Key('bottom-navigation-small'),
                    builder: (context) => AdaptiveScaffold.standardBottomNavigationBar(
                      currentIndex: widget.index,
                      destinations: destinations,
                      onDestinationSelected: (value) => tapOnNavigationDestination(context, value),
                    )
                )
              }
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                  key: const Key('primary-body-small'),
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Centinelas'),
                      automaticallyImplyLeading: false,
                      elevation: 8.0,
                      actions: [
                        Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                context.goNamed(ProfilePageWidgetProvider.pageConfig.name,);
                              },
                              child: const Icon(
                                Icons.person_2_rounded,
                                size: 26.0,
                              ),
                            )
                        ),
                      ],
                    ),
                    body: HomePage.tabs[widget.index].child,
                  )
              ),
              Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('primary-body-medium-up'),
                  builder: (_) => HomePage.tabs[widget.index].child
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('secondary-body-medium'),
                  builder: widget.index != 0 ? null : (_) =>
                      BlocBuilder<NavigationCubit, NavigationCubitState>(
                        builder: (context, state) {
                          final selectedRaceId = state.selectedRaceId;
                          final isSecondBodyDisplayed = Breakpoints.mediumAndUp.isActive(context);

                          context.read<NavigationCubit>().secondBodyHasChanged(
                            isSecondBodyDisplayed: isSecondBodyDisplayed,
                          );

                          if(selectedRaceId == null){
                            return const Center();
                          }
                          return RaceDetailPageProvider(
                            key: Key(selectedRaceId.value),
                            raceEntryIdString: selectedRaceId.value,
                          );
                        },
                      ),
              )
            },
          ),
        ),
      ),
    );
  }

  void tapOnNavigationDestination(BuildContext context, int index){
    serviceLocator<FirebaseAnalytics>().logEvent(
        name: firebaseEventGoToProfile
    );
      context.go('/$homeRoute/${HomePage.tabs[index].name}');
  }
}
