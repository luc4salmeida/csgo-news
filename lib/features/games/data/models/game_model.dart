import 'package:meta/meta.dart';

import '../../domain/entities/game.dart';
import '../../domain/entities/team.dart';
import 'team_model.dart';

class GameModel extends Game
{
  GameModel({
    @required String event,
    @required String maps,
    @required Team team1,
    @required Team team2,
    @required String matchId

  }) : super(
    event: event,
    maps: maps,
    team1: team1,
    team2: team2,
    matchId: matchId
  );

  factory GameModel.fromJson(Map<String, dynamic> map) {
    return GameModel(
      event: map['event'] as String,
      maps: map['maps'] as String,
      matchId: map['matchId'] as String,
      team1: TeamModel.fromJson(map['team1']),
      team2: TeamModel.fromJson(map['team2'])
    );
  }
}