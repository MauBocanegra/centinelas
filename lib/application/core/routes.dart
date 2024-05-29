import 'dart:convert';

import 'package:centinelas_app/application/app/bloc/auth_cubit.dart' as auth;
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/dispatch/dispatch_page.dart';
import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/incidences/incidence_page.dart';
import 'package:centinelas_app/application/pages/map/map_page.dart';
import 'package:centinelas_app/application/pages/privacy/privacy_page.dart';
import 'package:centinelas_app/application/pages/profile/profile_page.dart';
import 'package:centinelas_app/application/pages/race_detail/race_detail_page.dart';
import 'package:centinelas_app/application/pages/session/session_page.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import 'go_router_observer.dart';
import 'routes_constants.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/${SessionPageProvider.pageConfig.name}',
  observers: [
    GoRouterObserver(),
    serviceLocator<FirebaseAnalyticsObserver>()
  ],
  routes: [
    GoRoute(
      name: SessionPageProvider.pageConfig.name,
      path: '/${SessionPageProvider.pageConfig.name}',
      builder: (context, state) => BlocProvider<auth.AuthCubit>(
        create: (context) => serviceLocator<auth.AuthCubit>(),
        child: const SessionPageProvider(),
      ),
    ),
    GoRoute(
      name: LoginPage.pageConfig.name,
      path: '/${LoginPage.pageConfig.name}',
      builder: (context, state) => const LoginPage()
    ),
    GoRoute(
      name: ProfilePageWidgetProvider.pageConfig.name,
      path: '/${ProfilePageWidgetProvider.pageConfig.name}',
      builder: (context, state) => const ProfilePageWidgetProvider()
    ),
    GoRoute(
      name: HomePage.pageConfig.name,
      path: '/$homeRoute',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: DispatchPage.pageConfig.name,
      path: '/$dispatchRoute',
      builder: (context, state) {
        final data = state.extra! as Map<String,dynamic>;
        return DispatchPage(
          raceId: data[raceEntryIdKey],
          route: data[raceGoogleMapRouteKey],
          points: data[raceGoogleMapPointsKey],
        );
      }
    ),
    /*
    GoRoute(
      name: IncidencesPageProvider.pageConfig.name,
      path: '/$incidencesRoute',
      builder: (context, state) => IncidencesPageProvider(),
    ),
    */
    GoRoute(
        name: PrivacyPageProvider.pageConfig.name,
        path: '/${PrivacyPageProvider.pageConfig.name}',
        builder: (context, state) {
          return const PrivacyPageProvider();
        }
    ),
    GoRoute(
      name: MapPageProvider.pageConfig.name,
      path: '/$homeRoute/$racesRoute/${MapPageProvider.pageConfig.name}/:$raceFullIdParamKey/:$raceRouteParamKey/:$racePointsParamKey',
      builder: (context, state){
        return MapPageProvider(
          raceIdString: (state.pathParameters[raceFullIdParamKey] ?? ''),
          raceRoute: (state.pathParameters[raceRouteParamKey] ?? ''),
          racePoints: (jsonDecode(state.pathParameters[racePointsParamKey] ?? '')),
        );
      }
    ),
    GoRoute(
      name: RaceDetailPage.pageConfig.name,
      path: '/$homeRoute/$racesRoute/:raceEntryId',
      builder: (context, state) {
        return BlocListener<NavigationCubit, NavigationCubitState>(
          listenWhen: (previous, current) => previous.isSecondBodyDisplayed != current.isSecondBodyDisplayed,
          listener: (context, state){
            if(context.canPop() && (state.isSecondBodyDisplayed ?? false )){
              context.pop();
            }
          },
          child: RaceDetailPageProvider(
            raceEntryIdString: state.pathParameters['raceEntryId'] ?? '',
          ),
        );
      }
    ),
  ],
);