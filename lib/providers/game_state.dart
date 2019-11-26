import 'package:flutter/foundation.dart';

enum GameStates { Home, Help, Playing, GameOver }

class GameState with ChangeNotifier {
  GameStates _state;

  GameState() {
    _state = GameStates.Home;
  }

  GameStates get state {
    return _state;
  }

  void setGameState(GameStates newState) {
    _state = newState;
    notifyListeners();
  }
}
