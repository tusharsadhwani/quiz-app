import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/question_counter.dart';
import './widgets/questions/question_card.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final int _totalTimePerQuestion = 10;

  final List<Map<String, dynamic>> _questions = [
    {
      "title": "1. Meaning",
      "question": "What is the meaning of Life?",
      "answers": [
        "Yes",
        "No",
        "42",
      ]
    },
    {
      "title": "2. Long Question",
      "question":
          "Two brothers. In a van. And then a meteor hit. And they ran as fast as they could. From giant cat-monsters. And then a giant tornado came. And that's when things got knocked into twelfth gear... A Mexican...armada shows up. With weapons made from to- tomatoes. And you better betch'ur bottom dollar that these two brothers know how to handle business. In! 'Alien...Invasion Tomato Monster Mexican Armada Brothers...Who Are Just Regular Brothers Running...in a Van from an...Asteroid and All Sorts of Things: The Movie' Hold on! There's more. Old women are comin'! And they're also in the movie and they're gonna come...and cross...attack...these two brothers. But let's get back to the brothers because they're- they have a strong bond! You don't wanna know about it here, but I'll tell you one thing. The Moon. It comes crashing into Earth! And whaddya do then? It's two brothers and I- and...and they're gonna...it's called 'Two Brothers' ...'Two Brothers'...it's just called 'Two Brothers' lmfao",
      "answers": [
        "What",
        "The",
        "Heck",
        "Is",
        "This",
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: QuestionCounter(totalQuestions: _questions.length),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          itemCount: _questions.length,
          itemBuilder: (ctx, index) =>
              QuestionCard(index, _questions[index], _totalTimePerQuestion),
        ),
      ),
    );
  }
}
