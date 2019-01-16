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

  Text answerSection = Text('_ _ _ _ _ _');

  @override
  Widget build(BuildContext context) {
    Widget userInput = TextField(
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Please enter a letter'
      ),
    );

    RaisedButton button = new RaisedButton(
      child: new Text('Play!'),
      color: Colors.blueAccent,
      onPressed: toto(),
    );

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

  updateAnswer() {

    answerSection = Text('potato');
  }
  toto() {

    answerSection = Text('TOTO');
  }
}
