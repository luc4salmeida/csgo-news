import 'package:csgo_flutter/features/games/domain/entities/game.dart';
import 'package:csgo_flutter/features/games/domain/repositories/game_repository.dart';
import 'package:csgo_flutter/features/games/domain/usecases/get_game_by_match_id.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGameRepository extends Mock 
  implements GameRepository
{}

void main() {

  GetGameByMatchId useCase;
  MockGameRepository mockGameRepository ;

  setUp(() {
    mockGameRepository = MockGameRepository();
    useCase = GetGameByMatchId(mockGameRepository);
  });


  final matchUrl = "2332210/liquid-vs-faze-blast-pro-series-miami-2019";
  final Game tGame = Game(
    event: "test",
    maps: "d2",
    matchId: "1",
    team1: null,
    team2: null
  );

  test(
  'should get game by match id from repository', 
  () async {

      // arrange
      when(mockGameRepository.getGameByMatchId(any))
        .thenAnswer((realInvocation) async => Right(tGame));

      //act
      final result = await useCase.execute(url: matchUrl);

      //asset
      expect(result, Right(tGame));
      verify(mockGameRepository.getGameByMatchId(matchUrl));
      verifyNoMoreInteractions(mockGameRepository);
  });
}

