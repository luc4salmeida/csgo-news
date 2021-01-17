import 'package:csgo_flutter/features/games/domain/entities/game.dart';
import 'package:csgo_flutter/features/games/presentation/bloc/games_bloc.dart';
import 'package:csgo_flutter/features/games/presentation/widgets/game_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csgo_flutter/injection_container.dart';
import 'package:intl/intl.dart';


class GamesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<GamesBloc>(),
      child: Builder(builder: (newCtx) => _buildStateLastGamesContent(newCtx)),
    );
  }

  Widget _buildStateLastGamesContent(BuildContext context) {

    BlocProvider.of<GamesBloc>(context).add(GetLastGamesEvent());

    return Center(
      child: BlocBuilder<GamesBloc, GamesState>(
        builder: (context, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          }
          else if (state is Error) {
            return Text(state.errorMessage);
          }
          else if (state is Loaded) {
            return _buildLastGamesList(context, state.lastGames);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLastGamesList(BuildContext context, List<Game> lastGames) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        
        if(lastGames[index + 1] != null) {
          DateTime atualGameTime = DateTime.parse(lastGames[index].time);
          DateTime afterGameTime = DateTime.parse(lastGames[index + 1].time);

          if(atualGameTime.day != afterGameTime.day) {

            String weekDay = DateFormat('EEEE').format(afterGameTime);
            String ydm = DateFormat.yMd().format(afterGameTime);

            return Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: Text(weekDay + " - " + ydm, style: TextStyle(fontSize: 21, color: Colors.grey.shade500))
            );
          }
        }
        return Container();
      },
      itemCount: lastGames.length,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameDisplay(model: lastGames[index]),
      )
    );
  }
}