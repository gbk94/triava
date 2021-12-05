import 'package:flutter/material.dart';
import 'package:trivia/data/web3/models/question.dart';
import 'package:trivia/view/screen/quiz_tab/quiz_tab_view_model.dart';

class SelectAnswer extends StatefulWidget {
  SelectAnswer({Key? key, required this.choices, required this.onValueSelected})
      : super(key: key);
  final List<UpComingChoice> choices;
  final Function(int) onValueSelected;

  @override
  State<SelectAnswer> createState() => _SelectAnswerState();
}

class _SelectAnswerState extends State<SelectAnswer> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onValueSelected(index);
              },
              child: Expanded(
                  child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color:
                        selectedIndex == index ? Colors.yellow : Colors.white,
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(widget.choices[index].text),
              )),
            ));
  }
}
