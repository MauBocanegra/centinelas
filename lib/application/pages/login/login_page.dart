import 'package:centinelas_app/application/core/strings.dart';
import 'package:centinelas_app/application/pages/login/widgets/google_sign_in_button.dart';
import 'package:centinelas_app/application/pages/privacy/privacy_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/page_config.dart';
import '../../core/routes_constants.dart';

/*
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  static const pageConfig = PageConfig(
    icon: Icons.login,
    name: loginRoute,
    child: LoginPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.deepOrangeAccent);
  }
}
*/
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.login,
    name: loginRoute,
  );

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LayoutBuilder(
                      builder: (context, constraints){
                        return Container(
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
                  TextButton(
                      onPressed: (){
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



