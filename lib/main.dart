import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';

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
  List<Map<String, bool>> _questionsAndAnswers = [
    {'You can lead a cow down stairs but not up stairs.': false},
    {'Approximately one quarter of human bones are in the feet.': true},
    {'A slug\'s blood is green.': true},
  ];

  List<Question> _questionList = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true)
  ];

  int _questionNumber = 0;

  late String questionText = _questionList[0].getText();

  void _progressInTheQuiz() {
    // When counting up, questionNumber will go for the last one in the list, that corresponds to .length - 1,  and the will show after setting, so it will appear in UI.
    // Next round it will check that it is in the limit, then it will go back to zero.
    // In normal loop it does not happen like this
    if (_questionNumber == (_questionList.length - 1)) {
      _questionNumber = 0;
    } else {
      _questionNumber++;
    }

    questionText = changeQuestionTextToNext();
  }

  bool _checkTheAnswers(bool answerGiven) {
    // print('$answerGiven and $_questionNumber');
    return answerGiven == _questionList[_questionNumber].getAnswer();
  }

  void _addNewScoreValueToScoreKeeper(bool answerGiven) {
    _scoreList.add(_rightOrWrongStringToIcon[answerGiven]!);
  }

  String changeQuestionTextToNext() {
    return _questionList[_questionNumber].getText();
  }

  void _answer(bool answerGiven) {
    bool answeredCorrectly = _checkTheAnswers(answerGiven);
    _addNewScoreValueToScoreKeeper(answeredCorrectly);
    _progressInTheQuiz();
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
