import 'package:centinelas_app/application/app/bloc/auth_cubit.dart';
import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/race_detail/bloc/race_detail_bloc.dart';
import 'package:centinelas_app/application/pages/race_detail/widgets/bloc/buttons_bloc/race_detail_buttons_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/bloc_full/races_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/bloc/race_entry_item_bloc.dart';
import 'package:centinelas_app/core/config.dart';
import 'package:centinelas_app/data/data_sources/interfaces/race_collection_id_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/race_entry_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/race_full_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/races_collection_firestore_datesource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/register_race_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/user_data_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/interfaces/user_id_write_firestore_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/implementations/incidence_write_realtime_datasource.dart';
import 'package:centinelas_app/data/data_sources/realtime_database/interfaces/incidence_write_realtime_datasource_interface.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/race_entry_firestore_datasource.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/race_full_firestore_datasource.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/races_collection_firestore_remote_datasource.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/races_collection_id_firestore_remote_datasource.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/register_race_write_firestore_datasource.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/user_data_firestore_datasource.dart';
import 'package:centinelas_app/data/data_sources/remote_impl/user_id_write_firestore_datasource.dart';
import 'package:centinelas_app/data/repository/races_collection_mock.dart';
import 'package:centinelas_app/data/repository/races_repository_imp.dart';
import 'package:centinelas_app/data/repository/realtime_repository_impl.dart';
import 'package:centinelas_app/data/repository/users_respository_impl.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:centinelas_app/domain/repositories/realtime_repository.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:centinelas_app/domain/usecases/load_race_entry_usecase.dart';
import 'package:centinelas_app/domain/usecases/load_race_full_usecase.dart';
import 'package:centinelas_app/domain/usecases/load_races_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_incidence_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_phone_write_checkin_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_race_checkin_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_race_engagement_usecase.dart';
import 'package:centinelas_app/domain/usecases/write_user_id_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  // factory = every new instance
  // singleton = only one instance

  // application layer
  serviceLocator.registerFactory(() => AuthCubit());
  serviceLocator.registerFactory(() => NavigationCubit());
  serviceLocator.registerFactory(() => RacesBloc(
      loadRacesUseCase: serviceLocator()
  ));
  serviceLocator.registerFactory(() => RaceEntryItemBloc(
      loadRaceEntryUseCase: serviceLocator(),
  ));
  serviceLocator.registerFactory(() => RaceDetailBloc(
      loadRaceFullUseCase: serviceLocator()
  ));
  serviceLocator.registerFactory(() => RaceDetailButtonsBloc(
    writeRaceEngagementUseCase: serviceLocator(),
    writeRaceCheckinUseCase: serviceLocator(),
    writePhoneWriteCheckInUseCase: serviceLocator(),
    writeIncidenceUseCase: serviceLocator(),
  ));

  // domain layer
  serviceLocator.registerFactory(() => LoadRacesUseCase(
      racesRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => LoadRaceFullUseCase(
      racesRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => LoadRaceEntryUseCase(
      raceRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => WriteUserIdUseCase(
      usersRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => WriteRaceEngagementUseCase(
      usersRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => WriteRaceCheckinUseCase(
      usersRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => WritePhoneWriteCheckInUseCase(
      usersRepository: serviceLocator()
  ));
  serviceLocator.registerFactory(() => WriteIncidenceUseCase(
      realtimeRepository: serviceLocator()
  ));

  // data layer
  if(isServerDataFetched){
    serviceLocator.registerFactory<RacesRepository>(() =>
        RacesRepositoryImpl()
    );
    serviceLocator.registerFactory<UsersRepository>(() =>
        UsersRepositoryImpl()
    );
    serviceLocator.registerFactory<RealtimeRepository>(() =>
        RealtimeRepositoryImpl()
    );
  } else {
    serviceLocator.registerFactory<RacesRepository>(() =>
        RacesRepositoryMock()
    );
  }

  // datasources
  serviceLocator
      .registerFactory<RaceCollectionIdFirestoreDatasourceInterface>(
          () =>RaceCollectionIdFirestoreDatasource()
  );
  serviceLocator
      .registerFactory<RacesEntriesIdsFirestoreDateSourceInterface>(
          () => RacesEntriesIdsFirestoreDatasource()
  );
  serviceLocator
      .registerFactory<RaceEntryFirestoreDatasourceInterface>(
          () => RaceEntryFirestoreDatasource()
  );
  serviceLocator
      .registerFactory<RaceFullFirestoreDatasourceInterface>(
          () => RaceFullFirestoreDatasource()
  );
  serviceLocator
      .registerFactory<UserIdWriteFirestoreDatasourceInterface>(
          () => UserIdWriteFirsetoreDatasource()
  );
  serviceLocator
      .registerFactory<WriteEngagementRaceFirestoreDatasourceInterface>(
          () => WriteEngagementRaceFirestoreDatasource()
  );
  serviceLocator
      .registerFactory<UserDataFirestoreDatasourceInterface>(
          () => UserDataFirestoreDatasource()
  );
  serviceLocator
      .registerFactory<IncidenceWriteRealtimeDataSourceInterface>(
          () => IncidenceWriteRealtimeDatasource()
  );


  // library instances
  serviceLocator.registerFactory(() async => await SharedPreferences.getInstance());
  serviceLocator.registerFactory(() => FirebaseAuth.instance);

  // Is this still needed?
  serviceLocator.registerFactory(() => serviceLocator<FirebaseAuth>().authStateChanges().listen((user) {
    // debugPrint here ?
    debugPrint('user: ${user.toString()}');
    serviceLocator<AuthCubit>().authStateChanged(user: user);
  }));

  serviceLocator.registerFactory(() => FirebaseFirestore.instance);
  serviceLocator.registerFactory(() => FirebaseDatabase.instance);
}