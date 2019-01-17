import 'package:flutter/material.dart';

enum Progress { inProgress, won, lost }

class GameEngine {

  int _allowedAttempts;
  String _answer;

  String wrongAnswers;
  String currentAnswer;

  GameEngine(String answer) {
    this._allowedAttempts = 7;
    this._answer = answer.toUpperCase();
    this.currentAnswer = answer.replaceAll(new RegExp(r'\w'), "_"); // _____
    wrongAnswers = "";
  }

  giveAnswer(String letter) {
    letter = letter.toUpperCase();
    var foundCorrectLetter = false;
    for(var i = 0; i < _answer.length; i++) {
      if (_answer[i] == letter) {
        currentAnswer = currentAnswer.replaceRange(i, i + 1, letter); // shit ?
        foundCorrectLetter = true;
      }
    }

    if (!foundCorrectLetter) {
      this.wrongAnswers += letter;
    }
  }

  Progress currentProgress() {
    if (wrongAnswers.length >= _allowedAttempts) {
      return Progress.lost;
    } else if (!currentAnswer.contains("_")) {
      return Progress.won;
    }
    return Progress.inProgress;
  }

  String imageName() {
    return "assets/Step" + wrongAnswers.length.toString() + ".png";
  }

  String prettyString(String s) {
    String tmp = "";
    for (var letter in s.split('')) {
      tmp += letter + " ";
    }
    return tmp;
  }
}
