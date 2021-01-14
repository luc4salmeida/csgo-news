import 'package:csgo_flutter/core/error/failure.dart';
import 'package:csgo_flutter/features/games/domain/entities/game.dart';
import 'package:dartz/dartz.dart';

abstract class GameRepository {
  Future<Either<Failure, Game>> getGameByMatchId(int id);
  Future<Either<Failure, List<Game>>>getLastGames();
}