import 'dart:convert';

import 'package:csgo_flutter/features/news/data/models/news_model.dart';
import 'package:csgo_flutter/features/news/domain/entities/news.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNewsModel = NewsModel(
    title: "FURIA add honda as sixth player",
    description: "The 20-year-old is in for a baptism of fire as he will make his first appearance with the team in the BLAST Premier Global Final.",
    link: "https://www.hltv.org/news/30981/furia-add-honda-as-sixth-player",
    date: "Thu, 14 Jan 2021 20:35:00 GMT"
  );

  test(
    'should be a subclass of Game entitie', 
    () async {
      //assert
      expect(tNewsModel, isA<News>());
    }
  );

  group('fromJson', () {
    test('should return a valid model when JSON is provided', () async {
      //arrange
      final Map<String, dynamic> map = json.decode(fixture('new.json'));

      //act
      final result = NewsModel.fromJson(map);

      //assert
      expect(result, tNewsModel);
    });
  });

  group('toJson', () {
    test('return a valid model when JSON is provided', () async {
      //arrange
      final Map<String, dynamic> result = tNewsModel.toJson();

      final expectedMap = {
        "title":"FURIA add honda as sixth player",
        "description":"The 20-year-old is in for a baptism of fire as he will make his first appearance with the team in the BLAST Premier Global Final.",
        "link":"https://www.hltv.org/news/30981/furia-add-honda-as-sixth-player",
        "date":"Thu, 14 Jan 2021 20:35:00 GMT"
      };

      //assert
      expect(result, expectedMap);
    });
  });
}