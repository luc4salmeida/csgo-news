import '../models/news_model.dart';

abstract class NewsRemoteDataSource
{
  /// Calls the https://hltv-api.vercel.app/api/news endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<List<NewsModel>> getLastNews();
}