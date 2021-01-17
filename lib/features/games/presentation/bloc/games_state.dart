part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  const GamesState();
  
  @override
  List<Object> get props => [];
}

class Empty extends GamesState {}

class Loading extends GamesState {}

class Loaded extends GamesState {
  final List<Game> lastGames;

  Loaded({@required this.lastGames}); 

  @override
  List<Object> get props => [lastGames];
}

class Error extends GamesState {
  final String errorMessage;

  Error({@required this.errorMessage});
}

