import 'package:csgo_flutter/core/usecases/usecase.dart';
import 'package:csgo_flutter/features/games/domain/entities/game.dart';
import 'package:csgo_flutter/features/games/domain/repositories/game_repository.dart';
import 'package:csgo_flutter/features/games/domain/usecases/get_last_games.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGameRepository extends Mock 
  implements GameRepository
{}

void main() {

  GetLastGames useCase;
  MockGameRepository mockGameRepository ;

  setUp(() {
    mockGameRepository = MockGameRepository();
    useCase = GetLastGames(mockGameRepository);
  });

  final List<Game> tGames = [
    Game(
      event: "",
      map: "",
      id: 1,
      link: "",
      team1: null,
      team2: null,
      eventCrest: "",
      stars: 0,
      time: ""
    )
  ];

  test(
  'should get last games from repository', 
  () async {

      // arrange
      when(mockGameRepository.getLastGames())
        .thenAnswer((realInvocation) async => Right(tGames));

      //act
      final result = await useCase(NoParams());

      //asset
      expect(result, Right(tGames));
      verify(mockGameRepository.getLastGames());
      verifyNoMoreInteractions(mockGameRepository);
  });
}

