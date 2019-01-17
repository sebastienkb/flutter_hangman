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

class _MyHomePageState extends State<MyHomePage> {
  Widget imageSection = Row(children: [Image.asset('assets/Step0.png')]);

  Widget wrongLettersSection = Row(children: [Text('A B C')]);

  @override
  Widget build(BuildContext context) {
    var word = "Toto";
    var answerController = new TextEditingController();
    var userInputController = new TextEditingController();

    TextField answerSection = TextField(
      controller: answerController,
    );

    TextField userInput = TextField(
      decoration: InputDecoration(
          border: InputBorder.none, hintText: 'Please enter a letter'),
      controller: userInputController,
    );

    for (var i = 0; i < word.length; i++) {
      answerController.text += "_ ";
    }

    void checkLetter(String letter) {
      var indexes = List<int>();
      for(var i = 0; i < word.length; i++) {
        if(word[i] == letter) {
          indexes.add(i);
        }
      }
      if(indexes.isEmpty) {
        //change picture and add letter to wrong letter section
      } else {
        //
      }
    }
    RaisedButton button = new RaisedButton(
        child: new Text('Play!'),
        color: Colors.blueAccent,
        onPressed: () {
          answerController.text += userInputController.text;
          userInputController.text = "";
        });

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          imageSection,
          wrongLettersSection,
          answerSection,
          userInput,
          button
        ],
      ),
    );
  }
}
