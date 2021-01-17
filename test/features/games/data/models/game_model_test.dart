import 'dart:convert';

import 'package:csgo_flutter/features/games/data/models/game_model.dart';
import 'package:csgo_flutter/features/games/data/models/team_model.dart';
import 'package:csgo_flutter/features/games/domain/entities/game.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tGameModel = GameModel(
    id: 20789,
    event: "FALA BRAZIL",
    eventCrest: "https://img-cdn.hltv.org/teamlogo/zQUPdUEf_wQgLO-QhDxQ64.svg?ixlib=java-2.1.0&s=6385d292e2432df8c82991b1ed3a3fa3",

    map:"mirage",
    stars: 1,
    time: "2021-01-17T09:00:00.000Z",
    link: "http//google.com",

    team1: TeamModel.fromJson({
      "name":"SPARX",
      "crest":"https://img-cdn.hltv.org/teamlogo/zQUPdUEf_wQgLO-QhDxQ64.svg?ixlib=java-2.1.0&s=6385d292e2432df8c82991b1ed3a3fa3",
      "result":0
    }),

    team2: TeamModel.fromJson({
      "name":"ttc",
      "crest":"https://img-cdn.hltv.org/teamlogo/Nsu3Bx5jLmrJzFAYSX7yvS.png?ixlib=java-2.1.0&s=f2fcae9a54190745e217c476fd644eb0",
      "result":2
    })
  );

  test(
    'should be a subclass of Game entitie', 
    () async {
      //assert
      expect(tGameModel, isA<Game>());
    }
  );

  group('fromJson', () {
    test('should return a valid model when JSON is provided', () async {
      //arrange
      final Map<String, dynamic> map = json.decode(fixture('game.json'));

      //act
      final result = GameModel.fromJson(map);

      //assert
      expect(result, tGameModel);
    });
  });
  
  group('toJson', () {
    test('should return a JSON map contain the proper data', () async {
      //act
      final result = tGameModel.toJson();

      //asset
      final expectedMap = {
        "id": 20789,
        "event": "FALA BRAZIL",
        "eventCrest": "https://img-cdn.hltv.org/teamlogo/zQUPdUEf_wQgLO-QhDxQ64.svg?ixlib=java-2.1.0&s=6385d292e2432df8c82991b1ed3a3fa3",

        "map":"mirage",
        "stars": 1,
        "time": "2021-01-17T09:00:00.000Z",
        "link": "http//google.com",

        "teams": [
          {
            "name": "SPARX",
            "crest": "https://img-cdn.hltv.org/teamlogo/zQUPdUEf_wQgLO-QhDxQ64.svg?ixlib=java-2.1.0&s=6385d292e2432df8c82991b1ed3a3fa3" ,
            "result": 0
          },
          {
            "name": "ttc",
            "crest": "https://img-cdn.hltv.org/teamlogo/Nsu3Bx5jLmrJzFAYSX7yvS.png?ixlib=java-2.1.0&s=f2fcae9a54190745e217c476fd644eb0" ,
            "result": 2
          }
        ],
    };

      expect(result, expectedMap);
    });
  });
}