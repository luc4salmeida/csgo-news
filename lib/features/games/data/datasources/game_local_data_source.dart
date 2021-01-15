import 'package:csgo_flutter/features/games/data/models/game_model.dart';

abstract class GameLocalDataSource
{ /// Gets the cached [List<GameModel>] which was gotten the last time
  /// the user had internet connection
  ///
  /// Throws a [CacheException] for all error codes
  Future<List<GameModel>> getLastGames();

  /// Gets the cached [List<GameModel>] which was gotten the last time
  /// the user had internet connection
  ///
  /// Throws a [CacheException] for all error codes
  Future<GameModel> getGameByMatchId(String id);

  Future<void> cacheGame(GameModel gameCache);
  Future<void> cacheLastGames(List<GameModel> lastGamesCache);
}