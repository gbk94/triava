import 'package:flutter/material.dart';

class AnswerTextField extends StatelessWidget {
  const AnswerTextField({Key? key, required this.title, required this.onChange})
      : super(key: key);
  final String title;
  final void Function(String) onChange;

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
          child: TextField(
              cursorColor: Colors.black,
              onChanged: onChange,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              )),
        )
      ],
    );
  }
}
