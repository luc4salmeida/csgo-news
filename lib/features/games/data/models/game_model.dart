import 'package:meta/meta.dart';

import '../../domain/entities/game.dart';
import 'team_model.dart';

class GameModel extends Game
{
  GameModel({
    @required int id,
    @required String link,

    @required String event,
    @required String eventCrest,
    @required String time, 
    @required int stars,

    @required String map,
    @required TeamModel team1,
    @required TeamModel team2,
  }) : super(
    id: id,
    link: link,

    event: event,
    eventCrest: eventCrest,
    stars: stars,
    time: time,

    map: map,
    team1: team1,
    team2: team2
  );

  factory GameModel.fromJson(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      link: map['link'],
      event: map['event']['name'],
      eventCrest: map['event']['crest'],
      time: map['time'],
      map: map['map'],
      stars: map['stars'],
      team1: TeamModel.fromJson(map['teams'][0]),
      team2: TeamModel.fromJson(map['teams'][1])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "link": link,
      "event": event,
      "eventCrest": eventCrest,
      "map": map,
      "time": time,
      "stars": stars,
      "teams": [
        (team1 as TeamModel).toJson(),
        (team2 as TeamModel).toJson(),
      ]
    };
  }
}