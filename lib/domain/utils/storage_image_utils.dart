import 'package:centinelas/application/di/injection.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageUrl(String path) async {
  final reference = serviceLocator<FirebaseStorage>().ref().child(path);
  final url = await reference.getDownloadURL();
  return url;
}