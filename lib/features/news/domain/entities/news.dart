import 'package:equatable/equatable.dart';

class News extends Equatable
{
  final String title;
  final String description;
  final String link;
  final String date;

  News({this.title, this.description, this.link, this.date});

  @override
  List<Object> get props => [title, link];
}