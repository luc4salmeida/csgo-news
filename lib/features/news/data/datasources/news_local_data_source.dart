import '../models/news_model.dart';

abstract class NewsLocalDataSource
{ /// Gets the cached [List<NewsModel>] which was gotten the last time
  /// the user had internet connection
  ///
  /// Throws a [CacheException] for all error codes
  Future<List<NewsModel>> getLastNews();


  Future<void> cacheLastNews(List<NewsModel> lastGamesCache);
}