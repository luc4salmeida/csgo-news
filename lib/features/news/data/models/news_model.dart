import 'package:csgo_flutter/features/news/domain/entities/news.dart';

import 'package:meta/meta.dart';

class NewsModel extends News
{
  NewsModel(
  {
    @required title,
    @required description,
    @required link,
    @required date
  }
  ) : super(
    title: title,
    description: description,
    link: link,
    date: date
  );

  factory NewsModel.fromJson(Map<String, dynamic> map) {
    return NewsModel(
      date: map['date'] as String,
      description: map['description'] as String,
      link: map['link'] as String,
      title: map['title'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'link': link,
      'date': date
    };
  }
}