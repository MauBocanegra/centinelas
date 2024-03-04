import 'package:centinelas_app/application/pages/login/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';

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
                  Image.asset('assets/icon/icon.png'),
                  const SizedBox(height: 24,),
                  GoogleSignInButton()
                ],
              ),
            ),
          )
      ),
    );
  }
}



