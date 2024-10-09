import 'dart:convert';
import 'dart:math';

import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Authentication {

  static Future<void> signOutFromGoogle({required BuildContext context}) async {
    FirebaseAuth auth = serviceLocator<FirebaseAuth>();
    final signOutResult = await auth.signOut();
    serviceLocator<FirebaseAnalytics>().logEvent(name: firebaseEventLogout);
    return signOutResult;
  }

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<UserCredential?> signInWithApple() async {
    // TRY was removed as we need to propagate the error in case of such
    //try {
      //final appleProvider = AppleAuthProvider();
      //appleProvider.addScope('email');
      //UserCredential userCredential =
        //await serviceLocator<FirebaseAuth>().signInWithProvider(appleProvider);
      AuthorizationCredentialAppleID authCredentialAppleID =
      await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId:
          'centinelas.sportspromotion.com.mx.centinelasApp',
          redirectUri:
          // For web your redirect URI needs to be the host of the "current page",
          // while for Android you will be using the API server that redirects back into your app via a deep link
          // NOTE(tp): For package local development use (as described in `Development.md`)
          Uri.parse('https://siwa-flutter-plugin.dev/'),
        ),
      );

      OAuthProvider oAuthProvider =
      OAuthProvider('apple.com');
      final AuthCredential credential = oAuthProvider.credential(
          idToken: authCredentialAppleID.identityToken,
          accessToken: authCredentialAppleID.authorizationCode
      );
      debugPrint('userCredential: ${credential.toString()}');
      final appleProvider = AppleAuthProvider();
      appleProvider.addScope('email');
      appleProvider.addScope('name');
      UserCredential userCredential =
      await serviceLocator<FirebaseAuth>().signInWithCredential(credential);
      debugPrint('firebaseUserCredential: ${userCredential.toString()}');
      debugPrint('firebaseUserCredential [User]: ${userCredential.user.toString()}');
      debugPrint('firebaseUserCredential [User.email]: ${userCredential.user?.email.toString()}');
      return userCredential;
      // if email is empty we have to retrieve it from previous signedIn
      //
      /*
    } on Exception catch (e) {
      debugPrint('catch: ${e.toString()}');
      Authentication.customSnackBar(
        content: 'Error occurred using Google Sign In. Try again.',
      );
      if(e is SignInWithAppleAuthorizationException){
        return null;
      }
      return ;
    }
    */
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
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}