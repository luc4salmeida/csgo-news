import 'package:csgo_flutter/core/usecases/usecase.dart';
import 'package:csgo_flutter/features/news/domain/entities/news.dart';
import 'package:csgo_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:csgo_flutter/features/news/domain/usecases/get_last_news.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNewsRepository extends Mock 
  implements NewsRepository
{}

void main() {

  GetLastNews useCase;
  MockNewsRepository mockNewsRepository ;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    useCase = GetLastNews(mockNewsRepository);
  });

  final tNews = News(
    title: "",
    date: "",
    description: "",
    link: ""
  );

  test(
  'should get last news from repository', 
  () async {

      // arrange
      when(mockNewsRepository.getLastNews())
        .thenAnswer((realInvocation) async => Right(tNews));

      //act
      final result = await useCase(NoParams());

      //asset
      expect(result, Right(tNews));
      verify(mockNewsRepository.getLastNews());
      verifyNoMoreInteractions(mockNewsRepository);
  });
}

