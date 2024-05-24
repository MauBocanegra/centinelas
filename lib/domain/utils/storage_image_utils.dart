import 'package:centinelas_app/application/di/injection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

Future<String> getImageUrl(String path) async {
  final reference = serviceLocator<FirebaseStorage>().ref().child(path);
  final url = await reference.getDownloadURL();
  debugPrint('newImageUrl: ${url}');
  return url;
}