import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/home/home_page.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/usecases/try_apple_login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppleSignInButton extends StatefulWidget {
  const AppleSignInButton({
    super.key,
    required this.onAppleLoginFailure
  });
  final VoidCallback onAppleLoginFailure;

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

          final tryAppleLoginUseCase =
            serviceLocator<TryAppleLoginUseCase>();
          final fetchedEmailFromAppleLogin =
            await tryAppleLoginUseCase.call(NoParams());
          fetchedEmailFromAppleLogin.fold(
              (fetchedEmail) => {
                context.goNamed(
                  HomePage.pageConfig.name,
                )
              },
              (failure) => {
                if(failure is EmptyAppleLoginFailure){
                  widget.onAppleLoginFailure()
                } else {
                  debugPrint("what went wrong: ${failure.toString()}")
                }
              }
          );

          setState(() {
            isSigningIn = false;
          });
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
