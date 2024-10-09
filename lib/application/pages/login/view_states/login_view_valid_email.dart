import 'dart:io';

import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/core/strings.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/login/widgets/google_sign_in_button.dart';
import 'package:centinelas/application/pages/privacy/privacy_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewValidEmail extends StatelessWidget {
  const LoginViewValidEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LayoutBuilder(
                      builder: (context, constraints){
                        return SizedBox(
                          height: MediaQuery.of(context).size.width / 3,
                          width: MediaQuery.of(context).size.width / 3,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.asset('assets/icon/icon.png'),
                          ),
                        );
                      }
                  ),
                  const SizedBox(height: 48,),
                  const GoogleSignInButton(),
                  Platform.isIOS ?
                  const Text('Sesión iniciada correctamente!')
                      :
                  Container(),
                  TextButton(
                    onPressed: (){
                      serviceLocator<FirebaseAnalytics>().logEvent(
                          name: firebaseEventGoToPrivacy
                      );
                      context.go('/${PrivacyPageProvider.pageConfig.name}');
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: privacyButtonText1,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: privacyButtonText2,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                                decoration: TextDecoration.underline,
                              )
                          ),
                          // can add more TextSpans here...
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
