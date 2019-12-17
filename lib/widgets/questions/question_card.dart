import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/question_counter.dart';

enum CardStates { Pending, Running, Completed }

class QuestionCard extends StatefulWidget {
  final int index;
  final int totalTime;
  final Map<String, dynamic> questionData;

  QuestionCard(this.index, this.questionData, this.totalTime);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with TickerProviderStateMixin {
  var _questionCardState = CardStates.Pending;

  AnimationController _timeController;
  Animation<double> _timeLeft;

  final _animationDuration = Duration(milliseconds: 300);
  final _contentMinHeight = 100.0;

  @override
  void initState() {
    super.initState();

    print('Card ${widget.index}');
    print('State: $_questionCardState');
    print('--------------------');

    _timeController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.totalTime,
      ),
    );

    _timeController.addStatusListener((animationStatus) {
      if (animationStatus == AnimationStatus.completed &&
          _questionCardState != CardStates.Completed) {
        _setQuestionCardState(CardStates.Completed);
        Provider.of<QuestionCounter>(context).incrementCounter();
      }
    });

    _timeLeft = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _timeController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  void _setQuestionCardState(CardStates newState) {
    setState(() {
      _questionCardState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_timeController.status == AnimationStatus.forward &&
        _questionCardState == CardStates.Completed) {
      _timeController.stop();
    }
    if (_questionCardState != CardStates.Running &&
        Provider.of<QuestionCounter>(context).currentQuestion == widget.index) {
      setState(() {
        _questionCardState = CardStates.Running;
        _timeController.forward();
        print('New Card ${widget.index}');
        print('New State: $_questionCardState');
        print('--------------------');
      });
    }

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
                    AnimatedContainer(
                      duration: _animationDuration,
                      foregroundDecoration: BoxDecoration(
                        color: _questionCardState == CardStates.Running
                            ? Colors.white.withOpacity(0.0)
                            : Colors.white,
                      ),
                      child: AnimatedBuilder(
                        animation: _timeLeft,
                        builder: (_, __) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 4, 4, 4),
                          child: CircularProgressIndicator(
                            value: _timeLeft.value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                duration: _animationDuration,
                curve: Curves.easeOut,
                vsync: this,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  constraints: _questionCardState == CardStates.Running
                      ? BoxConstraints(
                          minHeight: 100.0, maxHeight: double.infinity)
                      : BoxConstraints(minHeight: 0.0, maxHeight: 0.0),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: _contentMinHeight,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (_questionCardState == CardStates.Running)
                                Container(
                                  child: Text(
                                    widget.questionData['question'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                (widget.questionData['answers'] as List<String>)
                                    .map(
                                      (answer) => AnswerButton(
                                        answer,
                                        _setQuestionCardState,
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
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
  final Function setQuestionCardState;

  AnswerButton(this.text, this.setQuestionCardState);

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
          onPressed: () {
            setQuestionCardState(CardStates.Completed);
            Provider.of<QuestionCounter>(context).incrementCounter();
          }),
    );
  }
}
