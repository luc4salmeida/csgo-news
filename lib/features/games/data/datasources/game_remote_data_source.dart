import '../../domain/entities/game.dart';

abstract class GameRemoteDataSource
{
  /// Calls the https://hltv-api.vercel.app/api/{id} endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<Game> getGameByMatchId(String id);

  /// Calls the https://hltv-api.vercel.app/api/matches endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<List<Game>> getLastGames();
}