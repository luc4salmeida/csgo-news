import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:csgo_flutter/core/error/failure.dart';
import 'package:csgo_flutter/core/network/network_info.dart';
import 'package:csgo_flutter/features/games/data/datasources/game_local_data_source.dart';
import 'package:csgo_flutter/features/games/data/datasources/game_remote_data_source.dart';
import 'package:csgo_flutter/features/games/data/models/game_model.dart';
import 'package:csgo_flutter/features/games/data/repositories/game_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';


class MockRemoteDataSource extends Mock 
  implements GameRemoteDataSource {}

class MockLocalDataSource extends Mock 
  implements GameLocalDataSource {}

class MockNetworkInfo extends Mock 
  implements NetworkInfo {}

void main() {
  GameRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GameRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('getMatchById', () {


    final matchId = "matches/2332210/liquid-vs-faze-blast-pro-series-miami-2019";

    final tGameModel = GameModel(
      event: "",
      maps: "",
      matchId: "",
      team1: null,
      team2: null
    );

    test('should check if the device is connected', () async {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((realInvocation) async => true);

      repository.getGameByMatchId(matchId);

      verify(mockNetworkInfo.isConnected);
    }); 
    
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
      }); 

       test('should return remote data when the remote data source is sucessful', () async {
        //arrange
        when(mockRemoteDataSource.getGameByMatchId(any))
        .thenAnswer((realInvocation) async => tGameModel);

        //act
        final result = await repository.getGameByMatchId(matchId);

        //verify
        verify(mockRemoteDataSource.getGameByMatchId(matchId));
        expect(result, Right(tGameModel));
      });

      test('should cache remote data when the remote data source is sucessful', () async {
        //arrange
        when(mockRemoteDataSource.getGameByMatchId(any))
        .thenAnswer((realInvocation) async => tGameModel);

        //act
        await repository.getGameByMatchId(matchId);

        //verify
        verify(mockRemoteDataSource.getGameByMatchId(matchId));
        verify(mockLocalDataSource.cacheGame(tGameModel));
      });

      test('should return server failure when the remote data source is unsuccessful', () async {
        //arrange
        when(mockRemoteDataSource.getGameByMatchId(any))
          .thenThrow(ServerException());

        //act
        final result = await repository.getGameByMatchId(matchId);

        //verify
        verify(mockRemoteDataSource.getGameByMatchId(matchId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    group('device is offline', () {


      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
      }); 


      test('should return last locally cached data when cached data is present', () async {
        when(mockLocalDataSource.getGameByMatchId(matchId))
        .thenAnswer((_) async => tGameModel);

        final result = await repository.getGameByMatchId(matchId);

        
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getGameByMatchId(matchId));
        expect(result, Right(tGameModel));
      });
      
       test('should return cache failure when cached data is not present', () async {
        when(mockLocalDataSource.getGameByMatchId(matchId))
        .thenThrow(CacheException());

        final result = await repository.getGameByMatchId(matchId);
        
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getGameByMatchId(matchId));
        expect(result, Left(CacheFailure()));
      });
    });
  });

  group('getLastGames', () {

    final List<GameModel> tLastGamesModel = [
      GameModel(
        event: "",
        maps: "",
        matchId: "",
        team1: null,
        team2: null
      )
    ];

    test('should check if the device is connected', () async {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((realInvocation) async => true);

      repository.getLastGames();

      verify(mockNetworkInfo.isConnected);
    }); 
    
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
      }); 

       test('should return remote data when the remote data source is sucesseful', () async {
        //arrange
        when(mockRemoteDataSource.getLastGames())
        .thenAnswer((realInvocation) async => tLastGamesModel);

        //act
        final result = await repository.getLastGames();

        //verify
        verify(mockRemoteDataSource.getLastGames());
        expect(result, Right(tLastGamesModel));
      });

      test('should cache remote data when the remote data source is sucesseful', () async {
        //arrange
        when(mockRemoteDataSource.getLastGames())
        .thenAnswer((realInvocation) async => tLastGamesModel);

        //act
        await repository.getLastGames();

        //verify
        verify(mockRemoteDataSource.getLastGames());
        verify(mockLocalDataSource.cacheLastGames(tLastGamesModel));
      });

      test('should return server failure when the remote data source is unsuccessful', () async {
        //arrange
        when(mockRemoteDataSource.getLastGames())
          .thenThrow(ServerException());

        //act
        final result = await repository.getLastGames();

        //verify
        verify(mockRemoteDataSource.getLastGames());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    group('device is offline', () {


      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
      }); 


      test('should return last locally cached data when cached data is present', () async {
        when(mockLocalDataSource.getLastGames())
        .thenAnswer((_) async => tLastGamesModel);

        final result = await repository.getLastGames();

        
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastGames());
        expect(result, Right(tLastGamesModel));
      });
      
       test('should return cache failure when cached data is not present', () async {
        when(mockLocalDataSource.getLastGames())
        .thenThrow(CacheException());

        final result = await repository.getLastGames();
        
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastGames());
        expect(result, Left(CacheFailure()));
      });
    });
  });
}