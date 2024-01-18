import 'package:centinelas_app/domain/entities/user_model.dart';

abstract class UserLocalDataSourceInterface {
  Future<UserSessionModel> getSessionInfo();
  Future<bool> storeSessionInfo({required userSessionInfo});
}