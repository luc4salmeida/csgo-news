import 'dart:convert';

import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_local_data_source.dart';
import 'package:csgo_flutter/features/news/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'package:matcher/matcher.dart';



class MockSharedPreferences extends Mock implements SharedPreferences {
}


void main() {
  MockSharedPreferences mockSharedPreferences;
  NewsLocalDataSourceImpl newsLocalDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    newsLocalDataSourceImpl = NewsLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences
    );
  });

  group('getLastNews', 
  () {

    
    final cachedLastNews = json.decode(fixture('last_news_cached.json')) as List;
    final List<NewsModel> tLastNews = cachedLastNews.map(
      (e) => NewsModel.fromJson(e)
    ).toList();


    test('should return an List<News> from SharedPreferences if there is one', () async {
      //arrange
      when(mockSharedPreferences.getString(LAST_NEWS_CACHED)).thenAnswer(
        (realInvocation) => fixture('last_news_cached.json')
      );

      //act
      final result = await newsLocalDataSourceImpl.getLastNews();
      
      //asset
      verify(mockSharedPreferences.getString(LAST_NEWS_CACHED));
      expect(result, tLastNews);
    });

    test('should throw an CacheException if there is not a cached List<News>', () async {
      when(mockSharedPreferences.getString(LAST_NEWS_CACHED))
        .thenAnswer((realInvocation) => null);

      final call = newsLocalDataSourceImpl.getLastNews;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));

    });

    test('should call SharedPreferences to save the data', () async {
      await newsLocalDataSourceImpl.cacheLastNews(tLastNews);
      verify(mockSharedPreferences.setString(
        LAST_NEWS_CACHED, 
        json.encode(tLastNews.fold("", (previousValue, element) => json.encode(element.toJson())))
      ));
    });
  }); 
}