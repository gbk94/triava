import 'package:flutter/material.dart';

class AnswerText extends StatelessWidget {
  const AnswerText(
      {Key? key,
      required this.title,
      required this.answer,
      this.isTrue = false})
      : super(key: key);
  final String title;
  final String answer;
  final bool isTrue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isTrue ? Colors.green : Colors.white,
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(10)),
          child: Text(answer),
        ))
      ],
    );
  }
}
