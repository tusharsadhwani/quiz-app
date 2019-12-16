import 'package:flutter/foundation.dart';

enum QuestionCardStates { Pending, Running, Completed }

class QuestionCardState with ChangeNotifier {
  QuestionCardStates _state;

  QuestionCardState() {
    _state = QuestionCardStates.Pending;
  }

  QuestionCardStates get state {
    return _state;
  }

  void setQuestionCardState(QuestionCardStates newState) {
    _state = newState;
    notifyListeners();
  }
}
