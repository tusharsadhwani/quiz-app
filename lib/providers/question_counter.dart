import 'package:flutter/foundation.dart';

class QuestionCounter with ChangeNotifier {
  int _currentQuestion;
  int _totalQuestions;

  QuestionCounter({@required totalQuestions}) {
    _currentQuestion = 0;
    _totalQuestions = totalQuestions;
  }

  int get currentQuestion {
    return _currentQuestion;
  }

  void incrementCounter() {
    if (_currentQuestion < _totalQuestions) {
      _currentQuestion++;
      print("Counter is now $_currentQuestion");
      notifyListeners();
    }
  }
}
