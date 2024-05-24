import 'package:centinelas_app/application/di/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? getUserId(){
  return serviceLocator<FirebaseAuth>().currentUser?.email
      ?.replaceAll('.', '_')
      .replaceAll('\$', '_')
      .replaceAll('#', '_')
      .replaceAll('(', '_')
      .replaceAll(')', '_');
}

String formatCustomUID(String uid){
  return uid.replaceAll('.', '_')
      .replaceAll('\$', '_')
      .replaceAll('#', '_')
      .replaceAll('(', '_')
      .replaceAll(')', '_');
}