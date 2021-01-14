import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

class Team {
  final String name;
  final String crest;
  final int result;

  Team({
    @required this.name, 
    @required this.crest, 
    @required this.result
  });
}