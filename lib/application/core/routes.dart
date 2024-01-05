import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/race_detail/race_detail_page.dart';
import '../pages/splash/splash_page.dart';
import 'go_router_observer.dart';
import 'routes_constants.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/$homeRoute/$racesRoute',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SplashPage.pageConfig.name,
      path: '/$splashRoute',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      name: LoginPage.pageConfig.name,
      path: '/$loginRoute',
      builder: (context, state) => LoginPage(),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '/$homeRoute/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? racesRoute,
          ),
        ),
      ],
    ),
    GoRoute(
      name: RaceDetailPage.pageConfig.name,
      path: '/$homeRoute/$racesRoute/:collectionId',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detalles de carrera'),
            leading: BackButton(
              onPressed: (){
                if(context.canPop()){
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name,
                    pathParameters: {'tab' : RacesPage.pageConfig.name},
                  );
                }
              },
            ),
          ),
          body: RaceDetailPageProvider(
              collectionId: CollectionId.fromUniqueString(
                // any empty string will show error
                state.pathParameters['collectionId'] ?? '',
              )
          ),
        );
      },
    ),
  ],
);