import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trivia/data/local/shared_prefs.dart';
import 'package:trivia/data/networking/rest_service.dart';
import 'package:trivia/data/web3/contract_manager.dart';
import 'package:trivia/data/web3/models/question.dart';
import 'package:trivia/route/routes.dart';
import 'package:trivia/view/common/base_view_model.dart';
import 'package:web3dart/credentials.dart';

class ValidateQuestionViewModel extends BaseViewModel {
  Question question = Question(question: "", choices: [
    Choice(text: ""),
    Choice(text: ""),
    Choice(text: ""),
    Choice(text: "")
  ]);

  Future<void> getQuestion() async {
    Dio client = await RestService().getClient();
    final response = await client.get('/questions');
    debugPrint(jsonEncode(response.data));
    question = Question.fromJson(response.data);
    notify();
  }

  Future<void> validateQuestion(bool isValid) async {
    print(question.id);
    final response = await ContractManager.submitTransaction(
        "validateQuestion", [hex.decode(question.id.substring(2)), isValid]);

    print(response);
    navigate(Routes.mainTab, clearStack: true);
  }
}
