import 'package:centinelas_app/application/app/bloc/auth_bloc.dart';
import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/race_detail/bloc/race_detail_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/bloc_full/races_bloc.dart';
import 'package:centinelas_app/application/pages/races_list/widgets/race_entry_item/bloc/race_entry_item_bloc.dart';
import 'package:centinelas_app/core/config.dart';
import 'package:centinelas_app/data/repository/races_collection_mock.dart';
import 'package:centinelas_app/data/repository/races_repository_imp.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:centinelas_app/domain/usecases/load_race_entry_usecase.dart';
import 'package:centinelas_app/domain/usecases/load_race_full_usecase.dart';
import 'package:centinelas_app/domain/usecases/load_races_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  // factory = every new instance
  // singleton = only one instance

  // application layer
  serviceLocator.registerFactory(() => AuthBloc());
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

  // data layer
  if(isServerDataFetched){
    serviceLocator.registerFactory<RacesRepository>(() =>
        RacesRepositoryImpl(client: serviceLocator())
    );
  } else {
    serviceLocator.registerFactory<RacesRepository>(() =>
        RacesRepositoryMock()
    );
  }

  // library instances
  serviceLocator.registerFactory(() => Client());
}