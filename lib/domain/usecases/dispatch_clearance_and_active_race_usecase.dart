import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/entities/unique_id.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/races_repository.dart';
import 'package:centinelas/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';

class DispatchClearanceAndActiveRaceUseCase
    implements UseCase<Map<dynamic, dynamic>, NoParams>{

  const DispatchClearanceAndActiveRaceUseCase({
    required this.usersRepository,
    required this.racesRepository,
  });
  final UsersRepository usersRepository;
  final RacesRepository racesRepository;

  @override
  Future<Either<Map<dynamic, dynamic>, Failure>> call(NoParams params) async {

    try{
      String? fetchedFullRaceId = '';
      String? fetchedRaceRoute;
      Map<dynamic, dynamic> fetchedRacePoints = {};
      final userHasDispatchClearance =
        await usersRepository.isCurrentUserDispatchAuthorized();
      if(!userHasDispatchClearance){ return const Left({}); }
      final readRaceIdsEither = await racesRepository.readRaceEntryIds();
      late final List<RaceEntryId> raceEntryIdsList;
      readRaceIdsEither.fold(
        (fetchedRaceEntryIdsList) => raceEntryIdsList = fetchedRaceEntryIdsList,
        (failure) => Right(failure)
      );
      for(var raceEntryId in raceEntryIdsList){
        final eachRaceFullEither = await racesRepository.readRaceFull(raceEntryId);
        eachRaceFullEither.fold(
          (fetchedFullRace) {
            if(fetchedFullRace.isRaceActive){
              fetchedFullRaceId = fetchedFullRace.id.value;
              fetchedRaceRoute = fetchedFullRace.raceRoute;
              fetchedRacePoints = fetchedFullRace.racePoints;
            }
          },
          (failure) => Right(failure),
        );
      }
      return Left({
        raceGoogleMapRouteKey: fetchedRaceRoute ?? '',
        raceGoogleMapPointsKey: fetchedRacePoints,
        raceEntryIdKey : fetchedFullRaceId,
      });
    } on Exception catch (exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}