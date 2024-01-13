import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/profile/profile_page.dart';
import 'package:centinelas_app/application/pages/race_detail/race_detail_page.dart';
import 'package:centinelas_app/application/pages/races_list/races_page.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/splash/splash_page.dart';
import 'go_router_observer.dart';
import 'routes_constants.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
  navigatorKey: rootNavigatorKey,
  //initialLocation: '/$homeRoute/${RacesPage.pageConfig.name}',
  //initialLocation: '/${SplashPage.pageConfig.name}',
  initialLocation: '/${LoginPage.pageConfig.name}',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: LoginPage.pageConfig.name,
      path: '/${LoginPage.pageConfig.name}',
      builder: (context, state) => SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            context.pushNamed(
              HomePage.pageConfig.name,
              pathParameters: {'tab': RacesPage.pageConfig.name},
            );
          }),
          AuthStateChangeAction<UserCreated>((context, state) {
            context.pushNamed(
              HomePage.pageConfig.name,
              pathParameters: {'tab': RacesPage.pageConfig.name},
            );
          }),
        ],
      ),
    ),
    GoRoute(
      name: ProfilePage.pageConfig.name,
      path: '/${ProfilePage.pageConfig.name}',
      builder: (context, state) => ProfileScreen(
        actions: [
          SignedOutAction((context) {
            context.go(LoginPage.pageConfig.name);
          }),
        ],
      ),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '/$homeRoute/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab']!,
          ),
        ),
      ],
    ),
    GoRoute(
      name: RaceDetailPage.pageConfig.name,
      path: '/$homeRoute/$racesRoute/:collectionId/:raceEntryId',
      builder: (context, state) {
        return BlocListener<NavigationCubit, NavigationCubitState>(
          listenWhen: (previous, current) => previous.isSecondBodyDisplayed != current.isSecondBodyDisplayed,
          listener: (context, state){
            if(context.canPop() && (state.isSecondBodyDisplayed ?? false )){
              context.pop();
            }
          },
          child: Scaffold(
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
              collectionIdString: state.pathParameters['collectionId'] ?? '',
              raceEntryIdString: state.pathParameters['raceEntryId'] ?? '',
            ),
          ),
        );
      }
    ),
  ],
);