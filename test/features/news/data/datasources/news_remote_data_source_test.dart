import 'dart:convert';

import 'package:csgo_flutter/core/consts/api.dart';
import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_remote_data_source.dart';
import 'package:csgo_flutter/features/news/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import 'package:matcher/matcher.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NewsRemoteDataSourceImpl newsRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    newsRemoteDataSourceImpl = NewsRemoteDataSourceImpl(
      httpClient: mockHttpClient
    );
  });

  void setUpMockHttpClientRequest200() {
    when(mockHttpClient.get(BASE_API + 'news')).thenAnswer(
    (realInvocation) async => http.Response(
      fixture('last_news_cached.json'),
      200
    ));
  }

  void setUpMockHttpClientRequest404() {
    when(mockHttpClient.get(BASE_API + 'news')).thenAnswer(
    (realInvocation) async => http.Response(
      "Sample",
      404
    ));
  }


  group('getLastNews', () {

    final cachedLastNews = json.decode(fixture('last_news_cached.json')) as List;
    final List<NewsModel> tLastNews = cachedLastNews.map(
      (e) => NewsModel.fromJson(e)
    ).toList();


    test('should perform GET request on http client with matched endpoint', () async {
      setUpMockHttpClientRequest200();

      await newsRemoteDataSourceImpl.getLastNews();

      verify(mockHttpClient.get(BASE_API + "news"));
    }); 

    test('should return an List<NewsModel> when status code is 200', () async {
      setUpMockHttpClientRequest200();

      final result = await newsRemoteDataSourceImpl.getLastNews();

      expect(result, tLastNews);
    }); 

    test('should throws an ServerException when status code is 404', () async {
      setUpMockHttpClientRequest404();

      final call = newsRemoteDataSourceImpl.getLastNews;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    }); 
  });
}