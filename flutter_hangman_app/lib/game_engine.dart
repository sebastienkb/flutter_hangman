import 'package:random_words/random_words.dart';
import "dart:math";

enum Progress { inProgress, won, lost }

class GameEngine {

  int _allowedAttempts = 6;
  String answer;

  String wrongAnswers;
  String currentAnswer;

  GameEngine() {
    setup();
  }

  setup() {
    answer = nouns[new Random().nextInt(nouns.length)].toUpperCase();
    print(answer);
    currentAnswer = answer.replaceAll(new RegExp(r'\w'), "_"); // _____
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
