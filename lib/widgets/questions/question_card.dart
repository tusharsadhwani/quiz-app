import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final Animation<double> timeLeft;
  final Map<String, dynamic> questionData;

  QuestionCard(this.questionData, this.timeLeft);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          questionData['title'],
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: timeLeft,
                      builder: (_, __) => Padding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 4, 4),
                        child: CircularProgressIndicator(
                          value: timeLeft.value,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: 100,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  questionData['question'],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: (questionData['answers'] as List<String>)
                      .map(
                        (answer) => AnswerButton(answer),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String text;

  AnswerButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlineButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {},
      ),
    );
  }
}
