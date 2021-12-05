import 'package:flutter/material.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';
import 'package:trivia/view/screen/quiz_tab/quiz_tab_view_model.dart';

class QuizTabView extends StatelessWidget {
  const QuizTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuizTabViewModel>(
        initViewModel: () => QuizTabViewModel(),
        builder: (context, viewModel) => Container(
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
                    children: const [
                      Text(
                        "• There are 10 questions in the quiz.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " • In order to compete in a quiz you must have at least 1 avax in your wallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TriviaButton(
                    buttonTitle: "Join Quiz",
                    onPressed: () {
                      viewModel.getQuizes();
                    }),
              ],
            )));
  }
}
