class Question {
  String question;
  List<Choice> choices;

  Question({required this.question, required this.choices});
}

class Choice {
  String text;
  String title;
  bool isTrue;

  Choice({required this.text, required this.title, this.isTrue = false});
}
