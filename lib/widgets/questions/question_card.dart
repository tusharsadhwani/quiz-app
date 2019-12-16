import 'package:flutter/material.dart';

class QuestionCard extends StatefulWidget {
  final int index;
  final int totalTime;
  final Map<String, dynamic> questionData;

  QuestionCard(this.index, this.questionData, this.totalTime);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with SingleTickerProviderStateMixin {
  AnimationController _timeController;
  Animation<double> _timeLeft;

  @override
  void initState() {
    super.initState();

    _timeController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.totalTime,
      ),
    );

    _timeLeft = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _timeController,
        curve: Curves.linear,
      ),
    );
    _timeController.forward();
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

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
                          widget.questionData['title'],
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                    if (widget.index == 0)
                      AnimatedBuilder(
                        animation: _timeLeft,
                        builder: (_, __) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 4, 4, 4),
                          child: CircularProgressIndicator(
                            value: _timeLeft.value,
                          ),
                        ),
                      ),
                    if (widget.index != 0)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 4, 4, 4),
                        child: CircularProgressIndicator(
                          value: _timeLeft.value,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: 100,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.questionData['question'],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: (widget.questionData['answers'] as List<String>)
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
