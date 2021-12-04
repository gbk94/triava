import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  const TriviaButton(
      {Key? key,
      required this.buttonTitle,
      required this.onPressed,
      this.disabled = false})
      : super(key: key);
  final String buttonTitle;
  final void Function() onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: !disabled ? Colors.white : Colors.grey),
        child: SizedBox(
          height: 60,
          child: Center(
              child: Text(
            buttonTitle,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: !disabled ? Colors.black : Colors.black),
          )),
        ),
      ),
    );
  }
}
