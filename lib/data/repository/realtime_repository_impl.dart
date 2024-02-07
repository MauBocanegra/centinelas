import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/incidence_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/domain/repositories/realtime_repository.dart';
import 'package:flutter/material.dart';

class RealtimeRepositoryImpl extends RealtimeRepository{
  RealtimeRepositoryImpl();

  @override
  Future<bool> writeIncidenceInRealtimeDB(Map<String, dynamic> data) async {
    try{
      final writeIncidenceRealtimeDatasource =
          serviceLocator<IncidenceWriteRealtimeDataSourceInterface>();
      final wasAbleToWriteIncidence =
          await writeIncidenceRealtimeDatasource.writeIncidence(data);
      return wasAbleToWriteIncidence;
    } on Exception catch(exception){
      debugPrint('Error WriteIncidenceRealtimeDB: ${exception.toString()}');
      return false;
    }
  }
}