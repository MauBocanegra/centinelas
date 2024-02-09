import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/races_repository.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/src/either.dart';

class DispatchClearanceAndActiveRaceUseCase implements UseCase<String, NoParams>{

  const DispatchClearanceAndActiveRaceUseCase({
    required this.usersRepository,
    required this.racesRepository,
  });
  final UsersRepository usersRepository;
  final RacesRepository racesRepository;

  @override
  Future<Either<String, Failure>> call(NoParams params) async {

    try{
      String? fetchedFullRaceId;
      final userHasDispatchClearance =
        await usersRepository.isCurrentUserDispatchAuthorized();
      if(!userHasDispatchClearance){ return const Left(''); }
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
            }
          },
          (failure) => Right(failure),
        );
      }
      return Left(fetchedFullRaceId ?? '');
    } on Exception catch (exception){
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}