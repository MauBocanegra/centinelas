import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/interfaces/user_local_data_source_interface.dart';
import 'package:centinelas_app/domain/entities/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSourceImpl implements UserLocalDataSourceInterface{

  late final UserSessionModel userSessionModel;

  @override
  Future<UserSessionModel> getSessionInfo() {
    final SharedPreferences preferences = serviceLocator<SharedPreferences>();
    // TODO: implement getSessionInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> storeSessionInfo({required userSessionInfo}) {
    // TODO: implement storeSessionInfo
    throw UnimplementedError();
  }

}