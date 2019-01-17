import 'package:flutter/material.dart';

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

class GameEngine {

  int attempts;
  int allowedAttempts;
  String answer;
  String wrongAnswers;
  String currentAnswer;

  GameEngine(String answer, int allowedAttempts) {
    this.attempts = 0;
    this.allowedAttempts = allowedAttempts;
    this.answer = answer.toUpperCase();
    this.currentAnswer = answer.replaceAll(new RegExp(r'\w'), "_"); // _____
    print(currentAnswer);
    wrongAnswers = "";
  }

  giveAnswer(String letter) {
    letter = letter.toUpperCase();
    var foundCorrectLetter = false;
    for(var i = 0; i < answer.length; i++) {
      if (answer[i] == letter) {
        currentAnswer = currentAnswer.replaceRange(i, i + 1, letter); // shit ?
        foundCorrectLetter = true;
      }
    }

    if (!foundCorrectLetter) {
      attempts++;
      this.wrongAnswers += letter;
    }
  }

  String imageName() {
    return "assets/Step" + attempts.toString() + ".png";
  }

  String prettyString(String s) {
    String tmp = "";
    for (var letter in s.split('')) {
      tmp += letter + " ";
    }
    return tmp;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  GameEngine gameEngine = GameEngine("TESLA", 7);
//  Widget imageSection = Row(children: [Image.asset('assets/Step0.png')]);
  Image imageSection = Image.asset('assets/Step0.png');

  @override
  Widget build(BuildContext context) {
    var answerController = new TextEditingController();
    var wrongAnswersController = new TextEditingController();
    var userInputController = new TextEditingController();

    TextField answerSection = TextField(
      controller: answerController
    );

    TextField wrongAnswersSection = TextField(
      controller: wrongAnswersController
    );

    TextField userInput = TextField(
      decoration: InputDecoration(
          border: InputBorder.none, hintText: 'Please enter a letter'),
      controller: userInputController,
    );

    for (var i = 0; i < gameEngine.answer.length; i++) {
      answerController.text += "_ ";
    }

    RaisedButton button = new RaisedButton(
        child: new Text('Play!'),
        color: Colors.blueAccent,
        onPressed: () {
          gameEngine.giveAnswer(userInputController.text);
          answerController.text = gameEngine.prettyString(gameEngine.currentAnswer);
          wrongAnswersController.text = gameEngine.prettyString(gameEngine.wrongAnswers);
          print(gameEngine.imageName());
          imageSection = Image.asset(gameEngine.imageName());
          userInputController.text = "";
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
