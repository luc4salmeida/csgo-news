import 'package:csgo_flutter/core/consts/error_messages.dart';
import 'package:csgo_flutter/core/error/failure.dart';
import 'package:csgo_flutter/features/news/data/models/news_model.dart';
import 'package:csgo_flutter/features/news/domain/usecases/get_last_news.dart';
import 'package:csgo_flutter/features/news/presentation/bloc/news_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetLastNews extends Mock implements GetLastNews
{}

void main() {
  // ignore: close_sinks
  NewsBloc bloc;
  MockGetLastNews mockGetLastNews;

  setUp(() {
    mockGetLastNews = MockGetLastNews();
    bloc = NewsBloc(getLastNews: mockGetLastNews);
  });

  test('initialState should my Empty', () async {
    expect(bloc.state, Empty());
  });

  group('getLastNews', () {

    List<NewsModel> tLastNewsModel = [];

    test('should get data', () async {

      when(mockGetLastNews(any)).thenAnswer(
        (realInvocation) async => Right(tLastNewsModel)
      );

      bloc.add(GetLastNewsEvent());
      await untilCalled(mockGetLastNews(any));
      

      verify(mockGetLastNews(any));
    });

    test('should emit [Loading, Loaded] when data is gotten successfuly', () async {

      when(mockGetLastNews(any)).thenAnswer(
        (realInvocation) async => Right(tLastNewsModel)
      );

      final expected =[
        Loading(),
        Loaded(lastNews: tLastNewsModel)
      ];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
      bloc.add(GetLastNewsEvent());
    });

    test('should emit [Loading, Error] when remote data is not gotten successfuly', () async {

      when(mockGetLastNews(any)).thenAnswer(
        (realInvocation) async => Left(ServerFailure())
      );

      final expected =[
        Loading(),
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
      bloc.add(GetLastNewsEvent());
    });

    test('should emit [Loading, Error] when cache data is not gotten successfuly', () async {

      when(mockGetLastNews(any)).thenAnswer(
        (realInvocation) async => Left(CacheFailure())
      );

      final expected =[
        Loading(),
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
      bloc.add(GetLastNewsEvent());
    });
  }); 
}