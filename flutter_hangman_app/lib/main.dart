import 'package:flutter/material.dart';
import 'game_engine.dart';
import 'package:random_words/random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Hangman game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GameEngine gameEngine = GameEngine();

  Image imageSection = Image.asset('assets/Step0.png');
  var answerController = new TextEditingController();
  var wrongAnswersController = new TextEditingController();
  var userInputController = new TextEditingController();

  void refresh() {
    setState(() {
      if (userInputController.text.length >= 1) {
        gameEngine.giveAnswer(userInputController.text.substring(0, 1));
      }
      answerController.text = gameEngine.prettyString(gameEngine.currentAnswer);
      wrongAnswersController.text = gameEngine.prettyString(gameEngine.wrongAnswers);
      userInputController.text = "";
      imageSection = Image.asset(gameEngine.imageName());
      if (gameEngine.currentProgress() != Progress.inProgress) {
        var alertDialog = AlertDialog(
          title: Text("You " + gameEngine.currentProgress().toString().split(".")[1] + " !\nThe correct answer was: \n\n" + gameEngine.answer),
          actions: <Widget>[
            FlatButton(
              child: new Text('Again!'),
              onPressed: () {
                gameEngine.setup();
                refresh();
                Navigator.of(context, rootNavigator: true).pop();
              }
            )
          ]
        );
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return alertDialog;
          }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    TextField answerSection = TextField(
      enabled: false,
      controller: answerController
    );

    TextField wrongAnswersSection = TextField(
      enabled: false,
      controller: wrongAnswersController
    );

    TextField userInput = TextField(
      autofocus: true,
      decoration: InputDecoration(
          border: InputBorder.none, hintText: 'Please enter a letter'),
      controller: userInputController,
      onChanged: (newValue) {
        userInputController.text = newValue.substring(0, 1);
      }
    );

    answerController.text = gameEngine.prettyString(gameEngine.currentAnswer);

    RaisedButton button = new RaisedButton(
        child: new Text('Play!'),
        color: Colors.blueAccent,
        onPressed: () {
          refresh();
        });

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          imageSection,
          wrongAnswersSection,
          answerSection,
          userInput,
          button
        ],
      ),
    );
  }
}
