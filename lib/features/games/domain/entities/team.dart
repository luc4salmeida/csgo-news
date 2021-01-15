
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Team extends Equatable{
  final String name;
  final String crest;
  final int result;

  Team({
    @required this.name, 
    @required this.crest, 
    @required this.result
  });

  @override
  List<Object> get props => [name, crest, result];
}