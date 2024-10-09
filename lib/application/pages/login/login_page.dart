import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/login/bloc/login_bloc.dart';
import 'package:centinelas/application/pages/login/view_states/login_view_initial.dart';
import 'package:centinelas/application/pages/login/view_states/login_view_noemail.dart';
import 'package:centinelas/application/pages/login/view_states/login_view_valid_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

class LoginPageProvider extends StatelessWidget {
  const LoginPageProvider({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.login,
    name: loginRoute,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => serviceLocator<LoginBloc>(),
        child: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if(state is SuccessfulLoginState){
            debugPrint("SuccessLoginState emited");
            return const LoginViewValidEmail();
          }if(state is NoEmailAppleLoginState){
            debugPrint("NoEmailLoginState emited");
            return const LoginViewNoemail();
          }else{
            debugPrint("InitialLoginState emited");
            return const LoginViewInitial();
          }
        }
    );
  }
}