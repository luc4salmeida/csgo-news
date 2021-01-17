part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

class Empty extends NewsState {}

class Loading extends NewsState {}

class Loaded extends NewsState {
  final List<News> lastNews;

  Loaded({@required this.lastNews});

  @override
  List<Object> get props => [lastNews];
}

class Error extends NewsState {
  final String errorMessage;

  Error({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
