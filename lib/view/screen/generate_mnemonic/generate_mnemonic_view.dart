import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';
import 'package:trivia/view/screen/generate_mnemonic/generate_mnemonic_view_model.dart';
import 'package:trivia/view/screen/generate_wallet/generate_wallet_view_model.dart';

class GenerateMnemonicView extends StatelessWidget {
  const GenerateMnemonicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GenerateMnemonicViewModel>(
        initViewModel: () => GenerateMnemonicViewModel(),
        onModelReady: (viewModel) => {viewModel.init()},
        builder: (context, viewModel) => Container(
              color: TAColors.red,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: TAColors.red,
                  body: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "Back up your wallet now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Write down or copy these words in the right order and save them somewhere safe",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 200,
                          color: Colors.white,
                          child: Text(viewModel.mnemonic,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 40),
                        TextButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: viewModel.mnemonic));
                            },
                            child: const Text("Copy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                        const Spacer(),
                        TriviaButton(
                            buttonTitle: "Create a Wallet",
                            onPressed: () {
                              viewModel.createWallet();
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
