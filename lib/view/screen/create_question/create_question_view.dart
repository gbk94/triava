import 'package:flutter/material.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/picker_view.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';
import 'package:trivia/view/screen/create_question/create_question_view_model.dart';
import 'package:trivia/view/screen/create_question/widget/answer_text_field.dart';

class CreateQuestionView extends StatelessWidget {
  const CreateQuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateQuestionViewModel>(
        initViewModel: () => CreateQuestionViewModel(),
        builder: (context, viewModel) => Container(
              color: TAColors.red,
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: TAColors.red,
                  ),
                  body: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      color: TAColors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "Create & Earn",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Question",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                    cursorColor: Colors.black,
                                    onChanged: (value) {},
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
                                const SizedBox(height: 20),
                                const Text(
                                  "Answers",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                AnswerTextField(
                                    onChange: (value) {}, title: "A"),
                                const SizedBox(height: 10),
                                AnswerTextField(
                                    onChange: (value) {}, title: "B"),
                                const SizedBox(height: 10),
                                AnswerTextField(
                                    onChange: (value) {}, title: "C"),
                                const SizedBox(height: 10),
                                AnswerTextField(
                                    onChange: (value) {}, title: "D"),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Text(
                                      "True Answer:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: PickerView(
                                      items: viewModel.questionAnswerLabels,
                                      onValueChanged: (index) {},
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          TriviaButton(
                              buttonTitle: "Create Question", onPressed: () {}),
                        ],
                      )),
                ),
              ),
            ));
  }
}
