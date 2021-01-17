import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:csgo_flutter/core/consts/error_messages.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/game.dart';
import '../../domain/usecases/get_last_games.dart';

part 'games_event.dart';
part 'games_state.dart';


class GamesBloc extends Bloc<GamesEvent, GamesState> {

  final GetLastGames getLastGames;

  GamesBloc({
    @required this.getLastGames
  }) 
  : assert(getLastGames != null),
  super(Empty());


  @override
  Stream<GamesState> mapEventToState(
    GamesEvent event,
  ) async* {
    if(event is GetLastGamesEvent) {
      
      yield Loading();
      final resultEither = await getLastGames(NoParams());

      yield* resultEither.fold(
        (failure) async* {
          yield Error(errorMessage: _mapFailureToMessage(failure));
        },
        (games) async* {
          yield Loaded(lastGames: games);
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
