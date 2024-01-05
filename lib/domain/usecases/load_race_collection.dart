import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';

import '../../core/usecase.dart';
import '../entities/race_collection.dart';
import '../failures/failures.dart';
import '../repositories/races_repository.dart';

class LoadRaceCollectionsUseCase implements UseCase<List<RaceCollection>, NoParams> {

  const LoadRaceCollectionsUseCase({required this.racesRepository});
  final RacesRepository racesRepository;

  @override
  Future<Either<List<RaceCollection>, Failure>> call(NoParams params) async {
    try {
      final loadedCollections = racesRepository.readRacesCollections();
      return loadedCollections.fold(
          (collection) => Left(collection),
          (failure) => Right(failure),
      );
    } on Exception catch(e){
      return Right(ServerFailure(stackTrace: e.toString()));
    }
  }

}