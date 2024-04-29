import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {

  static Future<void> signOutFromGoogle({required BuildContext context}) async {
    FirebaseAuth auth = serviceLocator<FirebaseAuth>();
    final signOutResult = await auth.signOut();
    serviceLocator<FirebaseAnalytics>().logEvent(name: firebaseEventLogout);
    return signOutResult;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = serviceLocator<FirebaseAuth>();
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        serviceLocator<FirebaseAnalytics>().setUserId(id: user?.email);
        serviceLocator<FirebaseAnalytics>().logLogin();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential' && context.mounted) {
          serviceLocator<FirebaseCrashlytics>().recordError(e, e.stackTrace);
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
              'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential' && context.mounted) {
          serviceLocator<FirebaseCrashlytics>().recordError(e, e.stackTrace);
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
              'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
        serviceLocator<FirebaseCrashlytics>().recordError(e, e.stackTrace);
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content:
            'Error occurred while accessing credentials. Try again.',
          ),
        );
      } on Exception catch (e) {
        // handle the error here
        if(context.mounted) {
          serviceLocator<FirebaseCrashlytics>().recordError(e,null);
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred using Google Sign In. Try again.',
            ),
          );
        }
      }
    } else {
      debugPrint("GoogleSignInAccount is null");
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      serviceLocator<FirebaseCrashlytics>().recordError(e, null);
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}