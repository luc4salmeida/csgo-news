import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/consts/api.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/game.dart';
import '../models/game_model.dart';

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


class GameRemoteDataSourceImpl implements GameRemoteDataSource
{
  final http.Client httpClient;

  GameRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<Game> getGameByMatchId(String id) async {
    final response = await httpClient.get(BASE_API + id);

    if(response.statusCode != 200) {
      throw ServerException();
    }

    return GameModel.fromJson(json.decode(response.body));
  }

  @override
  Future<List<Game>> getLastGames() async {

    final response = await httpClient.get(BASE_API + 'matches');

    if(response.statusCode != 200) {
      throw ServerException();
    }

    final remoteData = json.decode(response.body) as List; 
    final List<GameModel> remoteGames = remoteData.map(
      (e) => GameModel.fromJson(e)
    ).toList();

    return remoteGames;
  }

}