import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/game_state.dart';
import './questions.dart';
import './start_menu.dart';
import './help.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GameState(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MyHomePage(title: 'Quiz App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    switch (Provider.of<GameState>(context).state) {
      case GameStates.Home:
        bodyContent = StartMenu();
        break;
      case GameStates.Playing:
        print("Now Playing");
        bodyContent = Questions();
        break;
      case GameStates.Help:
        print("HELP");
        bodyContent = HelpText();
        break;
      case GameStates.GameOver:
      default:
        bodyContent = StartMenu();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: bodyContent,
    );
  }
}
