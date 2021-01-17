import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetGameByMatchId implements UseCase<Game, Params>
{
  final GameRepository repository;
  GetGameByMatchId(this.repository);

  @override
  Future<Either<Failure, Game>> call(Params params) {
    return repository.getGameByMatchId(params.id);
  }
}

class Params extends Equatable
{
  final int id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}