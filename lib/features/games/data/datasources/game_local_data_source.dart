import 'dart:convert';

import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game_model.dart';

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

const LAST_GAMES_CACHED = "LAST_GAMES_CACHED";
const LAST_GAME_CACHED = "LAST_GAME_CACHED";

class GameLocalDataSourceImpl implements GameLocalDataSource
{ 
  final SharedPreferences sharedPreferences;

  GameLocalDataSourceImpl({@required this.sharedPreferences});//this.repository);

  @override
  Future<List<GameModel>> getLastGames() {

    final cachedString = sharedPreferences.getString(LAST_GAMES_CACHED);

    if(cachedString == null) {
      throw CacheException();
    }

    final cachedData = json.decode(cachedString) as List; 
    final List<GameModel> cachedGames = cachedData.map(
      (e) => GameModel.fromJson(e)
    ).toList();

    return Future.value(cachedGames);
  }

  @override
  Future<GameModel> getGameByMatchId(String id) {
    final cachedString = sharedPreferences.getString(LAST_GAME_CACHED);

    if(cachedString == null) {
      throw CacheException();
    }
    final cachedData = json.decode(cachedString);
    return Future.value(GameModel.fromJson(cachedData));
  }

  @override
  Future<void> cacheGame(GameModel gameCache) {
    return sharedPreferences.setString(
      LAST_GAME_CACHED, 
      json.encode(gameCache.toJson())
    );
  }

  @override
  Future<void> cacheLastGames(List<GameModel> lastGamesCache) {
   return sharedPreferences.setString(
     LAST_GAMES_CACHED, 
     json.encode(lastGamesCache.fold<String>("", (previousValue, element) => previousValue + json.encode(element.toJson())))
    );
  }
  
}