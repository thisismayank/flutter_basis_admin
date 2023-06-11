import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/models/quiz.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';

class QuizDataApi {
  void getQuizData(userId, authToken, context, offset, limit) async {
    // var uri = Uri.parse("http://localhost:3000/v7.2/users/$userId/quiz");
    var uri = Uri.parse("https://api.getbasis.co/v7.2/users/$userId/quiz");

    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
    Map responseData = jsonDecode(response.body);

    if (responseData["success"] == false) {
      Provider.of<QuizDataStore>(context, listen: false)
          .setDataToQuizStore([], userId, authToken);
    } else {
      Provider.of<QuizDataStore>(context, listen: false)
          .setDataToQuizStore(responseData["results"], userId, authToken);
    }
    // print("LAST");
    // Navigator.pushNamed(context, "/quiz",
    //     arguments: {"context": context, "authToken": authToken});
    // return responseData;
  }

  void updateQuizData(userId, authToken, context, quizData) async {
    String body = json.encode({"quizData": quizData});
    // var uri = Uri.parse("http://localhost:3000/v7.3/admins/daily/quiz");
    var uri = Uri.parse("https://api.getbasis.co/v7.2/admins/daily/quiz");
    var response = await http.put(uri,
        headers: {
          "Authorization": 'Bearer $authToken',
          "content-type": "application/json"
        },
        body: body);
    Map responseData = jsonDecode(response.body);
    // print('HELLO ${responseData["results"]}');
    Provider.of<QuizDataStore>(context, listen: false)
        .setDataToQuizStore(responseData["results"], userId, authToken);
    // print("LAST");
    Navigator.pushNamed(context, "/quiz",
        arguments: {"context": context, "authToken": authToken});
    // return responseData;
  }

  void syncQuizData(userId, authToken, context) async {
    print("INSIDE THE API CALL");
    // var uri = Uri.parse("http://localhost:3000/v7.3/admins/sync/daily/quiz");
    var uri = Uri.parse("https://api.getbasis.co/v7.3/admins/sync/daily/quiz");
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
    Map responseData = jsonDecode(response.body);
    // print('HELLO ${responseData["results"]}');
    Provider.of<QuizDataStore>(context, listen: false)
        .setDataToQuizStore(responseData["results"], userId, authToken);
    // print("LAST");

    // return responseData;
  }
}
