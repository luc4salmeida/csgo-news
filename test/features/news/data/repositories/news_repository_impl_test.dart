

import 'package:csgo_flutter/core/network/network_info.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_local_data_source.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_remote_data_source.dart';
import 'package:csgo_flutter/features/news/data/models/news_model.dart';
import 'package:csgo_flutter/features/news/data/repositories/news_repository_impl.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../games/data/repositories/game_repository_impl_test.dart';


class MockRemoteDataSource extends Mock implements NewsRemoteDataSource 
{}

class MockLocalDataSource extends Mock implements NewsLocalDataSource 
{}

class MockNetWorkInfo extends Mock implements NetworkInfo 
{}

void main() {
  NewsRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NewsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('getLastNews', () {

    final List<NewsModel> tLastNews = [];

    test('should check if the device is connected', () async {
      when(mockNetworkInfo.isConnected)
        .thenAnswer((realInvocation) async => true);

      repository.getLastNews();

      verify(mockNetworkInfo.isConnected);
    });


    group('device is online', () {
    
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
      });

      test('should return remote data when the remote data source is sucessful', () async {
        when(mockRemoteDataSource.getLastNews())
          .thenAnswer((realInvocation) async => tLastNews);
          
        final result = await repository.getLastNews();

        verify(mockRemoteDataSource.getLastNews());
        expect(result, Right(tLastNews));
      });

      test('should cache remote data when the remote data source is sucessful', () async {
        when(mockRemoteDataSource.getLastNews())
          .thenAnswer((realInvocation) async => tLastNews);
          
        await repository.getLastNews();

        verify(mockRemoteDataSource.getLastNews());
        verify(mockLocalDataSource.cacheLastNews(tLastNews));
      });
    });
  });
}