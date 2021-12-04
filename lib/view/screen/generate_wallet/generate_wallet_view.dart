import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/route/routes.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';
import 'package:trivia/view/screen/generate_wallet/generate_wallet_view_model.dart';

class GenerateWalletView extends StatelessWidget {
  const GenerateWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GenerateWalletViewModel>(
        initViewModel: () => GenerateWalletViewModel(),
        builder: (context, viewModel) => Scaffold(
              backgroundColor: TAColors.red,
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      const Text(
                        "Welcome to Trivia",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      TriviaButton(
                          buttonTitle: "Create a Wallet",
                          onPressed: () {
                            viewModel.navigate(Routes.generateMnemonic);
                          }),
                      const Spacer(),
                      const Text(
                        "Powered by Avalanche Network",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      SvgPicture.asset('assets/images/avaxLogo.svg'),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ));
  }
}
