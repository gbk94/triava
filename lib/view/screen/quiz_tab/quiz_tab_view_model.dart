import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trivia/data/networking/rest_service.dart';
import 'package:trivia/data/web3/contract_manager.dart';
import 'package:trivia/data/web3/models/question.dart';
import 'package:trivia/route/routes.dart';
import 'package:trivia/view/common/base_view_model.dart';

class QuizTabViewModel extends BaseViewModel {
  Future<void> getQuizes() async {
    Dio client = await RestService().getClient();
    final response = await client.get('/events/upcoming');

    print(jsonEncode(response.data));
    // final json = jsonEncode(response.data);
    // joinQuiz(int.parse(json[0]['id']));
    List<UpcomingEvents> list = UpcomingEvents.fromMapList(response.data);
    // print(json[0]['id'].toString());
    joinQuiz(list[0].id, list[0]);
    print(list[0]);
  }

  Future<void> joinQuiz(int id, UpcomingEvents event) async {
    final data = await ContractManager.submitTransactionPayable(
        "joinQuiz", [BigInt.from(id)], ContractManager.avaxToWei("0.1"));
    print(data);

    QuizArgs(index: 0, upcomingEvent: event);
    navigate(Routes.quiz, args: QuizArgs(index: 0, upcomingEvent: event));
  }
}

class QuizArgs {
  int index;
  List<String> answers = List.empty(growable: true);
  UpcomingEvents upcomingEvent;

  QuizArgs({required this.index, required this.upcomingEvent});
}

class UpcomingEvents {
  int id;
  // double entryFee;
  List<UpComingQuestion> questions;
  UpcomingEvents({required this.id, required this.questions});

  factory UpcomingEvents.fromJson(Map<String, dynamic> json) => UpcomingEvents(
      id: json["id"],
      // entryFee: json['entryFee'],
      questions: (json['questions'])
          .map<UpComingQuestion>((e) => UpComingQuestion.fromJson(e))
          .toList());

  static List<UpcomingEvents> fromMapList(final List<dynamic> list) {
    return list.map<UpcomingEvents>((e) => UpcomingEvents.fromJson(e)).toList();
  }
}

class UpComingQuestion {
  String question;
  List<UpComingChoice> choices;
  String id;

  UpComingQuestion(
      {required this.question, required this.choices, this.id = ""});

  Map<String, dynamic> toJson() {
    return {'text': question, 'language': 'en', 'options': choices};
  }

  factory UpComingQuestion.fromJson(Map<String, dynamic> json) {
    return UpComingQuestion(
      id: json['id'],
      question: json['text'],
      choices: (json['options'])
          .map<UpComingChoice>(
              (e) => UpComingChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class UpComingChoice {
  String text;
  String title;
  String id;

  UpComingChoice({required this.text, this.title = "", required this.id});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'id': id,
    };
  }

  factory UpComingChoice.fromJson(Map<String, dynamic> json) {
    return UpComingChoice(text: json['text'], id: json['id']);
  }
}
