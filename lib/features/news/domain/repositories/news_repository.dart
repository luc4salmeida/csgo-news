import 'package:csgo_flutter/core/error/failure.dart';
import 'package:csgo_flutter/features/news/domain/entities/news.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getLastNews();
}