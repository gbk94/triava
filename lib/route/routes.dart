import 'package:flutter/material.dart';
import 'package:trivia/view/screen/create_question/create_question_view.dart';
import 'package:trivia/view/screen/generate_mnemonic/generate_mnemonic_view.dart';
import 'package:trivia/view/screen/generate_wallet/generate_wallet_view.dart';
import 'package:trivia/view/screen/main_tab/main_tab_view.dart';
import 'package:trivia/view/screen/quiz_view/quiz_veiw.dart';
import 'package:trivia/view/screen/validate_question/validate_question_view.dart';

class Routes {
  static const generateWallet = "generateWallet";
  static const generateMnemonic = "generateMnemonic";
  static const mainTab = "mainTab";
  static const createQuestion = "createQuestion";
  static const validateQuestion = "validateQuestion";
  static const quiz = "quiz";
}

Widget? createView(String route) {
  switch (route) {
    case Routes.generateWallet:
      return const GenerateWalletView();
    case Routes.generateMnemonic:
      return const GenerateMnemonicView();
    case Routes.mainTab:
      return const MainTabView();
    case Routes.createQuestion:
      return const CreateQuestionView();
    case Routes.validateQuestion:
      return const ValidateQuestionView();
    case Routes.quiz:
      return const QuizView();
    default:
  }
}

Route? onGenerateRoute(RouteSettings settings) {
  if (settings.name != null) {
    final child = createView(settings.name!);
    if (child != null) {
      return MaterialPageRoute(builder: (_) => child, settings: settings);
    }
  } else {
    return null;
  }
}
