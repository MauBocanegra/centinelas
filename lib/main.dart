import 'package:centinelas/application/app/bloc/auth_cubit.dart';
import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart' as di;
import 'package:centinelas/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/app/centinelas_app.dart';
import 'application/di/injection.dart';
import 'domain/repositories/races_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    //name:'centinelasApp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /// Error handled with crashlytics
  FlutterError.onError = (errorDetails) {
    serviceLocator<FirebaseCrashlytics>().recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    serviceLocator<FirebaseCrashlytics>().recordError(error, stack, fatal: true);
    return true;
  };

  serviceLocator<FirebaseFirestore>().settings = const Settings(
    persistenceEnabled: true,
  );
  //final fcmToken = await serviceLocator<FirebaseMessaging>().getToken(
    //vapidKey: fcmVapidKey
  //);
  serviceLocator<FirebaseMessaging>().onTokenRefresh
      .listen((fcmToken) {
    debugPrint('onTokenRefresh: $fcmToken');
  }).onError((err) {
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