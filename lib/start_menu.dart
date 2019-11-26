import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/game_state.dart';

class StartMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Provider.of<GameState>(context)
                    .setGameState(GameStates.Playing);
              },
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                'Help',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: () {
                Provider.of<GameState>(context).setGameState(GameStates.Help);
              },
            ),
          ),
        ],
      ),
    );
  }
}
