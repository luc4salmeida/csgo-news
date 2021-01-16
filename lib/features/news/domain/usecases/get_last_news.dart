import 'package:csgo_flutter/core/error/failure.dart';
import 'package:csgo_flutter/core/usecases/usecase.dart';
import 'package:csgo_flutter/features/news/domain/entities/news.dart';
import 'package:csgo_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetLastNews implements UseCase<List<News>, NoParams>
{
  final NewsRepository repository;

  GetLastNews(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await repository.getLastNews();
  }
}