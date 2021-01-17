import 'dart:convert';

import 'package:csgo_flutter/core/consts/api.dart';
import 'package:csgo_flutter/core/error/exceptions.dart';

import '../models/news_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource
{
  /// Calls the https://hltv-api.vercel.app/api/news endpoint
  /// 
  /// Throws a [ServerException] for all error codes
  Future<List<NewsModel>> getLastNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource
{

  final http.Client httpClient;

  NewsRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<List<NewsModel>> getLastNews() async {

    final response = await httpClient.get(BASE_API + "news");

    if(response.statusCode == 404) {
      throw ServerException();
    }

    final remoteData = json.decode(response.body) as List;
    
    return remoteData.map<NewsModel>(
      (e) => NewsModel.fromJson(e)
    ).toList();
  }
}