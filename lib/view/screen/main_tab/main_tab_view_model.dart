import 'package:trivia/view/common/base_view_model.dart';

class MainTabViewModel extends BaseViewModel<int> {
  String title = "";
  void setupTitle(int index) {
    switch (index) {
      case 0:
        title = "QUIZ";
        break;
      case 1:
        title = "WALLET";
        break;
      case 2:
        title = "QUESTION";
        break;
      default:
        title = "";
    }
    notify();
  }
}
