import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/utils/authentication.dart';
import 'package:centinelas/data/data_sources/libraries/interfaces/apple_login_datasource_interface.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginDatasource implements AppleLoginDatasourceInterface {
  @override
  Future<String> loginAndGetValidEmail() async {
    try{
      final appleLoginResult =
      await Authentication.signInWithApple();
      return appleLoginResult?.user?.email ?? "" ;
    } on Exception catch (exception) {
      if(exception is SignInWithAppleAuthorizationException){
        return "SignInWithAppleAuthorizationException";
      }
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return '';
    }
  }

}