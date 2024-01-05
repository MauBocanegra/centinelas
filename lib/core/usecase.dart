import 'package:centinelas_app/domain/entities/unique_id.dart';
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

class RaceEntryIdsParam extends Params{
  RaceEntryIdsParam({
    required this.collectionId,
    required this.entryId,
  }): super();
  final RaceEntryId entryId;
  final CollectionId collectionId;

  @override
  List<Object?> get props => [collectionId, entryId];
}

class CollectionIdParam extends Params{
  CollectionIdParam({
    required this.collectionId,
  }): super();
  final CollectionId collectionId;

  @override
  List<Object?> get props => [collectionId];
}