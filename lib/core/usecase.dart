import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Type, Failure>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}
