import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/race_ids_collection.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:flutter/cupertino.dart';

class LoadRacesUseCase implements UseCase<List<RaceEntryId>, NoParams>{
  const LoadRacesUseCase({required this.racesRepository});
  final RacesRepository racesRepository;

  @override
  Future<Either<List<RaceEntryId>, Failure>> call(NoParams params) async {
    try{
      final racesRepository = serviceLocator<RacesRepository>();
      return await racesRepository.readRaceEntryIds().fold(
          (raceEntryIdsList) => Left(raceEntryIdsList),
          (failure) => Right(failure),
      );
    }on Exception catch (exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}