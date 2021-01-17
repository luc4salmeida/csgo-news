import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/consts/error_messages.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/news.dart';
import '../../domain/usecases/get_last_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  final GetLastNews getLastNews;

  NewsBloc({@required this.getLastNews}) : 
  assert(getLastNews != null),
  super(Empty());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if(event is GetLastNewsEvent) {

      yield Loading();
      final resultEither = await getLastNews(NoParams());

      yield* resultEither.fold(
        (failure) async* {
          yield Error(errorMessage: _mapFailureToMessage(failure));
        },
        (news) async* {
          yield Loaded(lastNews: news);
        }
      );
    }
  }
  
  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }
}
