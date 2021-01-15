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
      date: map['date'],
      description: map['description'],
      link: map['link'],
      title: map['title']
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