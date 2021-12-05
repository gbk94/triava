import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:trivia/data/web3/contract_manager.dart';
import 'package:trivia/route/routes.dart';
import 'package:trivia/view/common/base_view_model.dart';
import 'package:trivia/view/screen/quiz_tab/quiz_tab_view_model.dart';

class QuizViewModel extends BaseViewModel<QuizArgs> {
  Future<void> nextQuestion() async {
    if (args.index + 1 < args.upcomingEvent.questions.length) {
      args.index++;
      navigate(Routes.quiz, args: args);
    } else {
      print(args.answers);
      submitQuiz(args.answers);
    }
  }

  Future<void> submitQuiz(List<String> answers) async {
    List<Uint8List> uInt8List = List.empty(growable: true);
    for (int i = 0; i < answers.length; i++) {
      uInt8List.add(Uint8List.fromList(hex.decode(answers[i].substring(2))));
    }
    final data = await ContractManager.submitTransaction(
        "submitQuiz", [BigInt.from(args.upcomingEvent.id), uInt8List]);
    print(data);
    navigate(Routes.mainTab, clearStack: true);
  }
}
