import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetGameByMatchId implements UseCase<Game, String>
{
  final GameRepository repository;
  GetGameByMatchId(this.repository);

  @override
  Future<Either<Failure, Game>> call({String params}) {
    return repository.getGameByMatchId(params);
  }
}