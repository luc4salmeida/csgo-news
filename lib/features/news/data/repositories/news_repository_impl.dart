import 'package:csgo_flutter/features/news/data/datasources/news_local_data_source.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_remote_data_source.dart';
import 'package:csgo_flutter/features/news/domain/entities/news.dart';
import 'package:csgo_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class NewsRepositoryImpl implements NewsRepository
{
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({@required this.remoteDataSource, @required this.localDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, List<News>>> getLastNews() async {
    try {
      if(await networkInfo.isConnected) {
        final remoteLastNews = await remoteDataSource.getLastNews();
        localDataSource.cacheLastNews(remoteLastNews);
        return Right(remoteLastNews);
      }
      return null;      
    } 
    on ServerException catch (_) {
      return Left(ServerFailure());
    }
    on CacheException catch (_) {
      return Left(CacheFailure());
    }
  }

  
}