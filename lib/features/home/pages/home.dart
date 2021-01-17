
import 'package:csgo_flutter/features/games/presentation/pages/games_page.dart';
import 'package:csgo_flutter/features/news/presentation/pages/news_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {


  TabController tabController;
  List<String> tabsName = [
    "News",
    "Matches",
    "Results"
  ];

  @override
  void initState() {

    tabController = TabController(
      length: tabsName.length, 
      vsync: this
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          tabs: tabsName.map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(e),
            )).toList()
        ),
      ),
      body: _buildBody(context),
    );
  }


  Widget _buildBody(BuildContext context) {
    return Container(
      child: TabBarView(
        controller: tabController,
        children: [
          NewsPage(),
          GamesPage(),
          Text("Soon.")
        ]
      )
    );
  }
}
