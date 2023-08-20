class Question {
  final String _questionText;
  final bool _questionAnswer;

  // this is a Dart syntatic sugar called formal initializers
  // it can be used to initialize non-nullable and also final instance variables (as above)
  // constructors are not inherited.

  Question(this._questionText, this._questionAnswer);

  //it is possible to make a "named constructor" that is like a specialized version of the constructor
  //below the constructor for the empty question
  //this below also is list initializer
  Question.empty()
      : _questionText = "",
        _questionAnswer = false;

  String getText() => this._questionText;
  bool getAnswer() => this._questionAnswer;
}
