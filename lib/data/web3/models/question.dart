class Question {
  String question;
  List<Choice> choices;
  String id;

  Question({required this.question, required this.choices, this.id = ""});

  Map<String, dynamic> toJson() {
    return {'text': question, 'language': 'en', 'options': choices};
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['text'],
      choices: (json['options'])
          .map<Choice>((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Choice {
  String text;
  String title;
  bool isTrue;

  Choice({required this.text, this.title = "", this.isTrue = false});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCorrect': isTrue,
    };
  }

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(text: json['text'], isTrue: json['isCorrect']);
  }
}
