import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/news.dart';
import '../bloc/news_bloc.dart';
import '../widgets/news_display.dart';

class NewsPage extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (ctx) => sl<NewsBloc>(),
      child: Builder(builder: (newCtx) => _buildStateLastGamesContent(newCtx)),
    );
  }

  Widget _buildStateLastGamesContent(BuildContext context) {

    BlocProvider.of<NewsBloc>(context).add(GetLastNewsEvent());

    return Center(
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          }
          else if (state is Error) {
            return Text(state.errorMessage);
          }
          else if (state is Loaded) {
            return _buildLastNewsList(context, state.lastNews);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLastNewsList(BuildContext context, List<News> lastNews) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: lastNews.length,
      itemBuilder: (_, index) => NewsDisplay(model: lastNews[index])
    );
  }
}