import 'package:centinelas_app/application/app/bloc/auth_bloc.dart';
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/app/centinelas_app.dart';
import 'data/repository/races_collection_mock.dart';
import 'domain/repositories/races_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: googleClientId),
  ]);

  final authBloc = AuthBloc();
  final authSubscription = FirebaseAuth
      .instance
      .authStateChanges()
      .listen((user) {
        debugPrint('user: $user');
          authBloc.authStateChanged(user: user);
      }
  );

  runApp(RepositoryProvider<RacesRepository>(
      create: (context) => RacesRepositoryMock(),
      child: BlocProvider<AuthBloc>(
          create: (context) => authBloc,
        child: const CentinelasApp(),
      )
  ));
}