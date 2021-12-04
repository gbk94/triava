import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/view/common/view_model_builder.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';
import 'package:trivia/view/screen/wallet/wallet_view_model.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>(
        initViewModel: () => WalletViewModel(),
        onModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel) => Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            color: TAColors.red,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 30,
                      child: Text(
                        viewModel.address,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: viewModel.address));
                        },
                        icon: const Icon(Icons.copy, color: Colors.grey)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/avaxLogo2.svg'),
                      const SizedBox(height: 20),
                      Text(
                        viewModel.balance + " AVAX",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Avax on Stake:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            viewModel.stakings + " AVAX",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(Icons.warning_amber_rounded),
                          SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              "In order to Create/Validate questions you must stake Avax Token",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            "Avax needed to create:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            viewModel.minCreatorAvax + " AVAX",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Avax needed to validate:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            viewModel.minValidatorAvax + " AVAX",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TriviaButton(
                    buttonTitle: "Stake Avax (Creator)", onPressed: () {}),
                const SizedBox(height: 20),
                TriviaButton(
                    buttonTitle: "Stake Avax (Validator)", onPressed: () {}),
              ],
            )));
  }
}
