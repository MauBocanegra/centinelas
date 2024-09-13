import 'package:centinelas/application/core/routes.dart';
import 'package:centinelas/application/pages/home/home_page.dart';
import 'package:centinelas/application/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppleSignInButton extends StatefulWidget {
  const AppleSignInButton({super.key});

  @override
  AppleSignInButtonState createState() => AppleSignInButtonState();

}

class AppleSignInButtonState extends State<AppleSignInButton> {
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: isSigningIn
          ? const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
        : OutlinedButton (
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          setState((){
            isSigningIn = true;
          });

          UserCredential? userCredential =
            await Authentication.signInWithApple();

          setState(() {
            isSigningIn = false;
          });

          if(userCredential != null && context.mounted){
            context.goNamed(
              HomePage.pageConfig.name,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Icon(Icons.apple),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Inicia sesión con Apple',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
