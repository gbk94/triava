import 'package:flutter/material.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';
import 'package:trivia/view/screen/quiz_view/quiz_view_model.dart';
import 'package:trivia/view/screen/quiz_view/widget/select_answer.dart';
import 'package:trivia/view/screen/validate_question/validate_question_view_model.dart';
import 'package:trivia/view/screen/validate_question/widget/answer_text.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuizViewModel>(
        initViewModel: () => QuizViewModel(),
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
                            "Quiz",
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
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(viewModel
                                          .args
                                          .upcomingEvent
                                          .questions[viewModel.args.index]
                                          .question),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Answers",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SelectAnswer(
                                    choices: viewModel
                                        .args
                                        .upcomingEvent
                                        .questions[viewModel.args.index]
                                        .choices,
                                    onValueSelected: (value) {
                                      viewModel.args.answers.add(viewModel
                                          .args
                                          .upcomingEvent
                                          .questions[viewModel.args.index]
                                          .choices[value]
                                          .id);
                                      viewModel.notify();
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          TriviaButton(
                              buttonTitle: viewModel.args.index + 1 <
                                      viewModel
                                          .args.upcomingEvent.questions.length
                                  ? "Next Question"
                                  : "Submit Quiz",
                              onPressed: () {
                                viewModel.nextQuestion();
                              }),
                        ],
                      )),
                ),
              ),
            ));
  }
}
