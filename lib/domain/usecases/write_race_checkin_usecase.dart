import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/data/sealed_classes/checkin_race_attempt_resolution.dart';
import 'package:centinelas_app/data/sealed_classes/race_engagement_type_request.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class WriteRaceCheckinUseCase implements
    UseCase<CheckInRaceAttemptResolution, String>{

  const WriteRaceCheckinUseCase({required this.usersRepository});
  final UsersRepository usersRepository;

  @override
  Future<Either<CheckInRaceAttemptResolution, Failure>> call(String raceId) async {
    try{
      final userDataModel = await usersRepository.readUserData();

      late final String userPhone;
      userDataModel.fold(
              (userData) {userPhone = userData.phone ?? '';} ,
              (failure) => Right(failure),
      );

      if(userPhone.isEmpty){
        return Left(
            NeedsPhoneUpdateCheckInRaceAttemptResolution()
        );
      } else {
        final wasAbleToCheckInRace =
          await usersRepository.writeRaceEngagementInFirestore(
            raceId,
            CheckInEngagementRequest()
          );
        if(wasAbleToCheckInRace){
          return Left(SuccessfulCheckInRaceAttemptResolution());
        } else {
          return Right(ServerFailure());
        }
      }
    } on Exception catch(exception) {
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }
}