import 'package:meta/meta.dart';

import '../../domain/entities/team.dart';

class TeamModel extends Team
{
  TeamModel({
    @required String name,
    @required String crest,
    @required int result,

  }) : super(
    name: name,
    crest: crest,
    result: result,
  );

  factory TeamModel.fromJson(Map<String, dynamic> map) {
    return TeamModel(
      name: map['name'] as String,
      crest: map['crest'] as String,
      result: map['result'] as int
    );
  }
}