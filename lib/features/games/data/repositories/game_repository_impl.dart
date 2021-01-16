import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/game.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/game_local_data_source.dart';
import '../datasources/game_remote_data_source.dart';

class GameRepositoryImpl implements GameRepository
{
  final GameRemoteDataSource remoteDataSource;
  final GameLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GameRepositoryImpl({@required this.remoteDataSource, @required this.localDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, Game>> getGameByMatchId(String id) async {
    try {
      if(await networkInfo.isConnected) {

        final remoteGame = await remoteDataSource.getGameByMatchId(id);
        localDataSource.cacheGame(remoteGame);

        return Right(remoteGame);
      } 
      else {
        final localGame = await localDataSource.getGameByMatchId(id);
        return Right(localGame);
      }
    } 
    on ServerException catch (_) {
      return Left(ServerFailure());
    }
    on CacheException catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Game>>> getLastGames() async {
    try {
      if(await networkInfo.isConnected) {
        
        final remoteLastGames = await remoteDataSource.getLastGames();
        localDataSource.cacheLastGames(remoteLastGames);

        return Right(remoteLastGames);
      } 
      else {
        final localLastGames = await localDataSource.getLastGames();
        return Right(localLastGames);
      }
    } 
    on ServerException catch (_) {
      return Left(ServerFailure());
    }
    on CacheException catch (_) {
      return Left(CacheFailure());
    }
  }
  
}