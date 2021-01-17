import 'dart:convert';

import 'package:csgo_flutter/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';


import '../models/news_model.dart';

abstract class NewsLocalDataSource
{ /// Gets the cached [List<NewsModel>] which was gotten the last time
  /// the user had internet connection
  ///
  /// Throws a [CacheException] for all error codes
  Future<List<NewsModel>> getLastNews();

  Future<void> cacheLastNews(List<NewsModel> lastGamesCache);
}

const LAST_NEWS_CACHED = "LAST_NEWS_CACHED";

class NewsLocalDataSourceImpl implements NewsLocalDataSource
{
  final SharedPreferences sharedPreferences;

  NewsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<NewsModel>> getLastNews() async {
    final cachedString = sharedPreferences.getString(LAST_NEWS_CACHED);

    if(cachedString == null) {
      throw CacheException();
    }

    final cachedNews = json.decode(cachedString) as List;
    return cachedNews.map<NewsModel>((e) => NewsModel.fromJson(e)).toList();
  }

  @override
  Future<void> cacheLastNews(List<NewsModel> lastGamesCache) {
    return sharedPreferences.setString(
      LAST_NEWS_CACHED, 
      json.encode(lastGamesCache.fold("", (previousValue, element) => json.encode(element.toJson())))
    );
  }
}
