import 'package:csgo_flutter/features/news/domain/entities/news.dart';
import 'package:flutter/material.dart';

class NewsDisplay extends StatelessWidget {

  final News model;

  const NewsDisplay({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(model.description, style: TextStyle(color: Colors.grey.shade300)),
        ],
      )
    );
  }
}