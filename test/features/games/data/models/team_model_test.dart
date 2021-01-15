import 'dart:convert';

import 'package:csgo_flutter/features/games/data/models/team_model.dart';
import 'package:csgo_flutter/features/games/domain/entities/team.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tTeamModel = TeamModel(
    name: "Test",
    crest: "https://google.com",
    result: 0
  );

  test(
    'should be a subclass of `Team` entitie', 
    () async {
      //assert
      expect(tTeamModel, isA<Team>());
    }
  );

  group('fromJson', () {
    test('should return a valid model when JSON is provided', () async {
      //arrange
      final Map<String, dynamic> map = json.decode(fixture('team.json'));

      //act
      final result = TeamModel.fromJson(map);

      //assert
      expect(result, equals(tTeamModel));
    });
  });

  
  group('toJson', () {
    test('should return a JSON map contain the proper data', () async {
      //act
      final result = tTeamModel.toJson();

      //asset
      final expectedMap = {
        "name":"Test",
        "crest":"https://google.com",
        "result":0
      };

      expect(result, expectedMap);
    });
  });
}