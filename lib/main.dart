import 'package:flutter/material.dart';

import 'package:quizzler/quiz_brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 42, 54, 61),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> _scoreList = [];

  Map<bool, Icon> _rightOrWrongStringToIcon = {
    true: Icon(
      Icons.check,
      color: Colors.green,
    ),
    false: Icon(
      Icons.close,
      color: Colors.red,
    ),
  };

  QuizBrain quizBrain = QuizBrain();

  late String questionText = quizBrain.getQuestionText();

  void resetScoreList() {
    _scoreList = [];
  }

  void _progressInTheQuiz() {
    if (quizBrain.hasNextQuestion()) {
      quizBrain.nextQuestion();
      questionText = changeQuestionTextToNext();
    } else {
      showAlertEndGame();
    }
  }

  bool _checkTheAnswers(bool answerGiven) {
    // print('$answerGiven and $_questionNumber');
    bool result = answerGiven == quizBrain.getQuestionAnswer();
    if (result) quizBrain.addPointToScore();
    return result;
  }

  void _addNewScoreValueToScoreKeeper(bool answerGiven) {
    _scoreList.add(_rightOrWrongStringToIcon[answerGiven]!);
  }

  String changeQuestionTextToNext() {
    return quizBrain.getQuestionText();
  }

  void _answer(bool answerGiven) {
    bool answeredCorrectly = _checkTheAnswers(answerGiven);
    _addNewScoreValueToScoreKeeper(answeredCorrectly);
  }

  void resetGame() {
    resetScoreList();
    quizBrain.resetQuiz();
  }

  void showAlertEndGame() {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('End of The Game!'),
        content: Text(
            'You finished the game with score ${quizBrain.getFinalScore()}'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, "false");
              resetGame();
              setState(() {});
            },
            child: const Text(
              'Finish Game',
              selectionColor: Colors.red,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, "true");
              resetGame();
              // setting state here is bad?
              setState(() {});
            },
            child: const Text(
              'Start Over',
              selectionColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 47, 178, 56),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool answerGiven = true;
                _answer(answerGiven);
                _progressInTheQuiz();
                setState(() {});
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 231, 42, 42),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                bool answerGiven = false;
                _answer(answerGiven);
                _progressInTheQuiz();
                setState(() {});
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: _scoreList,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
