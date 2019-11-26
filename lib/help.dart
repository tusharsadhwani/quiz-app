import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/game_state.dart';

class HelpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Help Text",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Help Text Body"),
          FlatButton(
            child: Text(
              "Go back",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Provider.of<GameState>(context).setGameState(GameStates.Home);
            },
          ),
        ],
      ),
    );
  }
}
