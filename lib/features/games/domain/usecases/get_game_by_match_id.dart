import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetGameByMatchId
{
  final GameRepository repository;
  GetGameByMatchId(this.repository);

  Future<Either<Failure, Game>> execute({@required String url}) async =>
    await repository.getGameByMatchId(url);
}