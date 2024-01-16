import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/routes.dart';

class CentinelasApp extends StatelessWidget {
  const CentinelasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => serviceLocator<NavigationCubit>(),
      child: MaterialApp.router(
        title: 'Centinelas',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        themeMode: ThemeMode.system,
        theme: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.cyan,
              brightness: Brightness.light, //Colo scheme. from seed, ThemeData
            )),
        darkTheme: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.cyan,
              //brightness: Brightness.dark,
            )),
        routerConfig: routes,
      ),
    );
  }
}
