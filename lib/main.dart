import 'package:centinelas_app/application/app/bloc/auth_cubit.dart';
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart' as di;
import 'package:centinelas_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/app/centinelas_app.dart';
import 'application/di/injection.dart';
import 'data/repository/races_collection_mock.dart';
import 'domain/repositories/races_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    //name:'centinelasApp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  serviceLocator<FirebaseFirestore>().settings = const Settings(
    persistenceEnabled: true,
  );
  final fcmToken = await serviceLocator<FirebaseMessaging>().getToken(
    vapidKey: fcmVapidKey
  );
  serviceLocator<FirebaseMessaging>().onTokenRefresh
      .listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
    debugPrint('onTokenRefresh: $fcmToken');
  })
      .onError((err) {
    // Error getting token.
    debugPrint('onERRORTokenRefresh: $err');
  });

  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: googleClientId),
  ]);

  runApp(RepositoryProvider<RacesRepository>(
      create: (context) => serviceLocator<RacesRepository>(),
      child: BlocProvider<AuthCubit>(
        create: (context) => serviceLocator<AuthCubit>(),
        child: const CentinelasApp(),
      )
  ));
}