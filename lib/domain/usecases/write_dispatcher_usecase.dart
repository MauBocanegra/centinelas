import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/domain/failures/failures.dart';
import 'package:centinelas/domain/repositories/realtime_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

class WriteDispatcherUseCase implements UseCase<bool, NoParams>{
  const WriteDispatcherUseCase({required this.realtimeRepository});
  final RealtimeRepository realtimeRepository;

  @override
  Future<Either<bool, Failure>> call(NoParams params) async {
    try{
      final wasAbleToWriteDispatcher =
        realtimeRepository.writeDispatcherInRealtimeDB();
      return wasAbleToWriteDispatcher.then(
              (value) => value ? Left(value) :
                throw Exception('Error writing FCMToken in RTBD')
      );
    } on Exception catch(exception){
      debugPrint('Exception WriteFCMTokenUseCase: ${exception.toString()}');
      return Right(ServerFailure(stackTrace: exception.toString()));
    }
  }

}