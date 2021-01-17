import 'package:csgo_flutter/features/games/data/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameDisplay extends StatelessWidget {

  final GameModel model;

  const GameDisplay({
    Key key, 
    @required this.model
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              _buildHoursTime(context),
              _buildStars(context),
              _buildBO(context)
            ],
          ),
          SizedBox(width: 20.0),
          Expanded(child: _buildTeams(context)),
          _buildEvent(context)
        ],
      )
    );
  }

  Widget _buildHoursTime(BuildContext context) {
    final dateTime = DateTime.parse(model.time);
    final dateFormatter = DateFormat.Hm();
    return Text(dateFormatter.format(dateTime));
  }

  Widget _buildStars(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, size: 8.0, color: model.stars >= 1 ? Colors.black87 : Colors.grey.shade300),
        Icon(Icons.star, size: 8.0, color: model.stars >= 2 ? Colors.black87 : Colors.grey.shade300),
        Icon(Icons.star, size: 8.0, color: model.stars >= 3 ? Colors.black87 : Colors.grey.shade300),
        Icon(Icons.star, size: 8.0, color: model.stars >= 4 ? Colors.black87 : Colors.grey.shade300),
        Icon(Icons.star, size: 8.0, color: model.stars >= 5 ? Colors.black87 : Colors.grey.shade300),
      ],
    );
  }

  Widget _buildBO(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade300,
      ),
      padding: EdgeInsets.all(6.0),
      child: Text(model.map, style: TextStyle(color: Colors.grey.shade500))
    );
  }

  Widget _buildTeams(BuildContext context) {
    return model.team1.name.isNotEmpty && model.team2.name.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.team1.name, style: TextStyle(fontWeight: FontWeight.bold)),
        Text("vs", textAlign: TextAlign.center),
        Text(model.team2.name, style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ) : Container();
  }

  Widget _buildEvent(BuildContext context) {
    return Text(model.event);
  }
}