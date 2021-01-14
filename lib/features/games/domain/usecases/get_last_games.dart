import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetLastGames
{
  final GameRepository repository;
  GetLastGames(this.repository);

  Future<Either<Failure, List<Game>>> execute() async =>
    await repository.getLastGames();
}