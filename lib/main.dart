import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/app/centinelas_app.dart';
import 'data/repository/races_collection_mock.dart';
import 'domain/repositories/races_repository.dart';

void main() {
  runApp(RepositoryProvider<RacesRepository>(
      create: (context) => RacesRepositoryMock(),
      child: const CentinelasApp()
  ));
}