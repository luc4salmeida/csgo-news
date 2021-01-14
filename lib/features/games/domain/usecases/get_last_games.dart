import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetLastGames implements UseCase<List<Game>, NoParams>
{
  final GameRepository repository;
  GetLastGames(this.repository);

  @override
  Future<Either<Failure, List<Game>>> call({NoParams params}) {
    return repository.getLastGames();
  }
}