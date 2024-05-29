import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/data/sealed_classes/checkin_race_attempt_resolution.dart';
import 'package:centinelas_app/domain/entities/user_data_model.dart';
import 'package:centinelas_app/domain/failures/failures.dart';
import 'package:centinelas_app/domain/repositories/users_repository.dart';
import 'package:either_dart/either.dart';

class WritePhoneWriteCheckInUseCase implements
  UseCase<CheckInRaceAttemptResolution, Map<String, dynamic>>{

  const WritePhoneWriteCheckInUseCase({
    required this.usersRepository
  });
  final UsersRepository usersRepository;

  @override
  Future<Either<CheckInRaceAttemptResolution, Failure>> call(Map<String, dynamic> map) async {
    final UserDataModel userDataModel = UserDataModel();
    userDataModel.phone = map[phoneKeyForMapping];
    userDataModel.emergencyContactPhone = '';
    userDataModel.emergencyContactName = '';
    userDataModel.severeAllergies = '';
    userDataModel.drugSensitivities = '';
    final wasAbleToUpdateData =
      await usersRepository.updateUserData(userDataModel);

    if(wasAbleToUpdateData){
      final wasAbleToRegisterRace =
          await usersRepository.writeRaceEngagementInFirestore(
              map[raceIdKeyForMapping],
              map[raceEngagementKeyForMapping],
          );
      if(wasAbleToRegisterRace){
        return Left(SuccessfulCheckInRaceAttemptResolution());
      } else { return Right(ServerFailure()); }
    } else { return Right(ServerFailure()); }
  }
}