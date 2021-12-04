import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/bottom_navigation_bar_item.widget.dart';
import 'package:trivia/view/screen/create_earn/create_earn_view.dart';
import 'package:trivia/view/screen/create_question/create_question_view.dart';
import 'package:trivia/view/screen/main_tab/main_tab_view_model.dart';
import 'package:trivia/view/screen/quiz_tab/quiz_view.dart';
import 'package:trivia/view/screen/wallet/wallet_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);
  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);

  void setPageIndex(int index, MainTabViewModel viewModel) {
    _pageIndexNotifier.value = index;
    viewModel.setupTitle(index);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainTabViewModel>(
      initViewModel: () => MainTabViewModel(),
      onModelReady: (viewModel) {
        setPageIndex(1, viewModel);
      },
      builder: (context, viewModel) => Container(
          color: TAColors.red,
          child: SafeArea(
              child: Scaffold(
            body: ValueListenableBuilder<int>(
              valueListenable: _pageIndexNotifier,
              builder: (context, currentIndex, _) {
                return IndexedStack(
                  index: currentIndex,
                  children: const [
                    QuizTabView(),
                    WalletView(),
                    CreateEarnView(),
                  ],
                );
              },
            ),
            bottomNavigationBar: ValueListenableBuilder<int>(
              valueListenable: _pageIndexNotifier,
              builder: (context, currentIndex, _) {
                return Container(
                  height: kToolbarHeight,
                  color: TAColors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomNavigationBarItemWidget(
                        iconPath: 'assets/images/quiz.svg',
                        selected: currentIndex == 0,
                        onTap: () => setPageIndex(0, viewModel),
                      ),
                      BottomNavigationBarItemWidget(
                        iconPath: 'assets/images/tabAvax.svg',
                        selected: currentIndex == 1,
                        onTap: () => setPageIndex(1, viewModel),
                      ),
                      BottomNavigationBarItemWidget(
                        iconPath: 'assets/images/questionTab.svg',
                        selected: currentIndex == 2,
                        onTap: () => setPageIndex(2, viewModel),
                      ),
                    ],
                  ),
                );
              },
            ),
          ))),
    );
  }
}
