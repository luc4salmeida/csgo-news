import 'dart:convert';

import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:csgo_flutter/features/games/data/datasources/game_local_data_source.dart';
import 'package:csgo_flutter/features/games/data/models/game_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockSharedPreferences extends Mock implements SharedPreferences
{}

void main() {
  MockSharedPreferences mockSharedPreferences;
  GameLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = GameLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final cachedListGames = json.decode(fixture('last_games_cached.json')) as List;
  final List<GameModel> tListGamesModel = cachedListGames.map(
    (e) => GameModel.fromJson(e)
  ).toList();

  final matchId = "test";
  final cachedGame = json.decode(fixture('game_cached.json'));
  final tGameModel = GameModel.fromJson(cachedGame);
  

  group('getLastGames', () {
    test('should return List<GameModel> from SharedPreferences when there is one in the cache', 
    () async {
      when(mockSharedPreferences.getString(any)).thenAnswer(
        (realInvocation) => fixture('last_games_cached.json'));

      final result = await dataSourceImpl.getLastGames();

      verify(mockSharedPreferences.getString(any));
      expect(result, tListGamesModel);
    });

    test('should throw a Exception when there is none in the cache', 
    () async {
      when(mockSharedPreferences.getString(any)).thenAnswer((_) => null);

      final call = dataSourceImpl.getLastGames;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    }); 

    test('should call SharedPreferences to save the data', 
    () async {
      await dataSourceImpl.cacheLastGames(tListGamesModel);
      verify(mockSharedPreferences.setString(
        LAST_GAMES_CACHED, 
        json.encode(tListGamesModel.fold<String>("", (previousValue, element) => previousValue + json.encode(element.toJson())
      ))));
    });  
  });

  group('getMatchByID', () {
    test('should return GameModel from SharedPreferences when there is one in the cache', 
    () async {
      when(mockSharedPreferences.getString(any)).thenAnswer(
        (realInvocation) => fixture('game_cached.json'));

      final result = await dataSourceImpl.getGameByMatchId(matchId);

      verify(mockSharedPreferences.getString(any));
      expect(result, tGameModel);
    });

    test('should throw a Exception when there is none in the cache', 
    () async {
      when(mockSharedPreferences.getString(any)).thenAnswer((_) => null);

      final call = dataSourceImpl.getGameByMatchId;

      expect(() => call(matchId), throwsA(TypeMatcher<CacheException>()));
    });

    
    test('should call SharedPreferences to save the data', 
    () async {
      await dataSourceImpl.cacheGame(tGameModel);
      verify(mockSharedPreferences.setString(
        LAST_GAME_CACHED, 
        json.encode(tGameModel.toJson())
      ));
    }); 
  });
}