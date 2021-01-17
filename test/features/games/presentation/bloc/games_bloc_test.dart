import 'package:csgo_flutter/core/consts/error_messages.dart';
import 'package:csgo_flutter/core/error/failure.dart';
import 'package:csgo_flutter/features/games/data/models/game_model.dart';
import 'package:csgo_flutter/features/games/domain/usecases/get_last_games.dart';
import 'package:csgo_flutter/features/games/presentation/bloc/games_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockGetLastGames extends Mock implements GetLastGames
{} 

void main() {

  // ignore: close_sinks
  GamesBloc bloc;
  MockGetLastGames mockGetLastGames;

  setUp(() {
    mockGetLastGames = MockGetLastGames();
    bloc = GamesBloc(getLastGames: mockGetLastGames);
  });

  test('initialState should my Empty', () async {
    expect(bloc.state, Empty());
  });

  group('GetLastGames', () {

    List<GameModel> tGameListModel = [];

    test('should get data', () async {

      when(mockGetLastGames(any)).thenAnswer(
        (realInvocation) async => Right(tGameListModel)
      );

      bloc.add(GetLastGamesEvent());
      await untilCalled(mockGetLastGames(any));
      

      verify(mockGetLastGames(any));
    });

    test('should emit [Loading, Loaded] when data is gotten successfuly', () async {

      when(mockGetLastGames(any)).thenAnswer(
        (realInvocation) async => Right(tGameListModel)
      );

      final expected =[
        Loading(),
        Loaded(lastGames: tGameListModel)
      ];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
      bloc.add(GetLastGamesEvent());
    });

    test('should emit [Loading, Error] when remote data is not gotten successfuly', () async {

      when(mockGetLastGames(any)).thenAnswer(
        (realInvocation) async => Left(ServerFailure())
      );

      final expected =[
        Loading(),
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
      bloc.add(GetLastGamesEvent());
    });

    test('should emit [Loading, Error] when cache data is not gotten successfuly', () async {

      when(mockGetLastGames(any)).thenAnswer(
        (realInvocation) async => Left(CacheFailure())
      );

      final expected =[
        Loading(),
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
      bloc.add(GetLastGamesEvent());
    });
  }); 
}