import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'team.dart';

class Game extends Equatable {
  final String event;
  final String maps;
  final Team team1;
  final Team team2;
  final String matchId;

  Game({
    @required this.event, 
    @required this.maps, 
    @required this.team1, 
    @required this.team2, 
    @required this.matchId
  });

  @override 
  List<Object> get props => [matchId];
}

