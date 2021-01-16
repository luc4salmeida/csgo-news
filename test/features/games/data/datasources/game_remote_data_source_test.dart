import 'dart:convert';

import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:csgo_flutter/features/games/data/datasources/game_local_data_source.dart';
import 'package:csgo_flutter/features/games/data/datasources/game_remote_data_source.dart';
import 'package:csgo_flutter/features/games/data/models/game_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient httpClient;
  GameRemoteDataSourceImpl gameRemoteDataSource;
  
  setUp(() {
    httpClient = MockHttpClient();
    gameRemoteDataSource = GameRemoteDataSourceImpl(
      httpClient: httpClient
    );
  });

  void setupMockHttpClientSucess200(String file) {
    when(httpClient.get(any)).thenAnswer((realInvocation) async => http.Response(
      fixture(file),
      200
    ));
  }

  void setupMockHttpClientFail404() {
    when(httpClient.get(any)).thenAnswer((realInvocation) async => http.Response(
      'something',
        404
    ));
  }

  group('getMatchByID', () {


    final tMatchUrl = "matches/2332210/liquid-vs-faze-blast-pro-series-miami-2019";
    final tGameModel = GameModel.fromJson(json.decode(fixture('game_cached.json')));

    test(
      'should perform http GET function with matches endpoint and returns the valid json', 
      () async {
        setupMockHttpClientSucess200('game_cached.json');

        await gameRemoteDataSource.getGameByMatchId(tMatchUrl);

        verify(httpClient.get(BASE_API + tMatchUrl));
      }
    );

    test(
      'should return GameModel when statusCode is 200 (success)', 
      () async {
        setupMockHttpClientSucess200('game_cached.json');

        final result = await gameRemoteDataSource.getGameByMatchId(tMatchUrl);

        expect(result, tGameModel);
      }
    );

    test(
      'should throw a ServerException when statusCode is 404 or other error code (fail)', 
      () async {

        setupMockHttpClientFail404();

        final call = gameRemoteDataSource.getGameByMatchId;

        expect(() => call(tMatchUrl), throwsA(TypeMatcher<ServerException>()));
      }
    );
  });

    group('getLastGames', () {

    final cachedListGames = json.decode(fixture('last_games_cached.json')) as List;
    final List<GameModel> tListGamesModel = cachedListGames.map(
      (e) => GameModel.fromJson(e)
    ).toList();

    test(
      'should perform http GET function with matches endpoint and returns the valid json', 
      () async {
        setupMockHttpClientSucess200('last_games_cached.json');

        await gameRemoteDataSource.getLastGames();

        verify(httpClient.get(BASE_API + 'matches'));
      }
    );

    test(
      'should return List<GameModel> when statusCode is 200 (success)', 
      () async {
        setupMockHttpClientSucess200('last_games_cached.json');

        final result = await gameRemoteDataSource.getLastGames();

        expect(result, tListGamesModel);
      }
    );

    test(
      'should throw a ServerException when statusCode is 404 or other error code (fail)', 
      () async {

        setupMockHttpClientFail404();

        final call = gameRemoteDataSource.getLastGames;

        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      }
    );
  });
}