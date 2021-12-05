import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trivia/data/local/shared_prefs.dart';
import 'package:trivia/data/networking/rest_service.dart';
import 'package:trivia/data/web3/contract_manager.dart';
import 'package:trivia/data/web3/models/question.dart';
import 'package:trivia/route/args/dialog_args.dart';
import 'package:trivia/utils/wallet_creation.dart';
import 'package:trivia/view/common/base_view_model.dart';
import 'package:web3dart/credentials.dart';
import 'package:convert/convert.dart';
import 'package:web3dart/crypto.dart';

class CreateQuestionViewModel extends BaseViewModel {
  final questionAnswerLabels = ['A', 'B', 'C', 'D'];
  String question = "";
  String optionA = "";
  String optionB = "";
  String optionC = "";
  String optionD = "";
  int? trueAnswerIndex;

  Future<void> createQuestion() async {
    if (question.isEmpty ||
        optionA.isEmpty ||
        optionB.isEmpty ||
        optionC.isEmpty ||
        optionD.isEmpty ||
        trueAnswerIndex == null) {
      dialog(DialogArgs(description: "Please fill all the blanks"));
    } else {
      flow(() async {
        List<Choice> choices = [
          Choice(title: 'A', text: optionA),
          Choice(title: 'B', text: optionB),
          Choice(title: 'C', text: optionC),
          Choice(title: 'D', text: optionD),
        ];
        choices[trueAnswerIndex!].isTrue = true;
        Question newQuestion = Question(question: question, choices: choices);

        EthPrivateKey credentials =
            EthPrivateKey.fromHex(SharedPrefs.instance.privateKey);

        final data = await ContractManager.query("calculateQuestionHash", [
          newQuestion.question,
          credentials.address,
        ]);
        print(data);
        List<dynamic> optionHashes = List.empty(growable: true);
        for (int i = 0; i < newQuestion.choices.length; i++) {
          final optionHash =
              await ContractManager.query("calculateOptionHash", [
            Uint8List.fromList(data[0].cast<int>().toList()),
            newQuestion.choices[i].text,
            newQuestion.choices[i].isTrue,
            credentials.address,
          ]);
          optionHashes.add(optionHash[0]);
        }

        print(optionHashes);
        print('Uint8List' +
            Uint8List.fromList(data[0].cast<int>().toList()).toString());

        final response = await ContractManager.submitTransaction(
          "createQuestion",
          [Uint8List.fromList(data[0].cast<int>().toList()), optionHashes],
        );
        print("create:" + response);
        createBackQuestion(newQuestion);
      });
    }
  }

  Future<void> createBackQuestion(Question newQuestion) async {
    print(newQuestion.choices.length);
    Dio client = await RestService().getClient();
    final response =
        await client.post('/questions', data: newQuestion.toJson());
    debugPrint(jsonEncode(response.data));
  }
}
