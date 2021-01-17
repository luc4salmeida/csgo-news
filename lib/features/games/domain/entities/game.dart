import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'team.dart';

class Game extends Equatable {
  final int id;
  final String link;

  final String event;
  final String eventCrest;
  final String time;

  final String map;
  final int stars;

  final Team team1;
  final Team team2;

  Game(
    {
    @required this.id,
    @required this.link,
    @required this.event, 
    @required this.eventCrest,
    @required this.time, 
    @required this.map,
    @required this.stars,
    @required this.team1, 
    @required this.team2, 
  });

  @override 
  List<Object> get props => [id];
}

