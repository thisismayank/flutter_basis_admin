import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/apis/quiz_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/quiz.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/quiz_data.dart';

import 'package:flutter_application_6_provider/pages/minty/selectable_chat.dart';
import 'package:provider/provider.dart';

class QuizDataWrapper extends StatelessWidget {
  const QuizDataWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataPassed = ModalRoute.of(context)?.settings.arguments as Map;

    String userId = userDataPassed["userId"];
    String authToken = userDataPassed["authToken"];
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    bool isButtonActive = currentHour > 21 || currentHour < 0;
    return Consumer<QuizDataStore>(builder: (context, quizData, child) {
      QuizDataApi quizDataApiObj = QuizDataApi();
      return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Quiz Data"),
            SizedBox(
              width: 16,
            ),
            Tooltip(
              message: isButtonActive
                  ? "Click this to sync data for tomorrow"
                  : "Please wait for the cron to run at 9 PM. Manual invocation allowed only between 9 PM and 11:59 PM.",
              child: TextButton(
                onPressed: () => isButtonActive == true
                    ? quizDataApiObj.syncQuizData(userId, authToken, context)
                    : null,
                child: const Text('Sync Quiz for tomorrow'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 48.0, vertical: 16)),
                  elevation: MaterialStateProperty.all(8),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
                  backgroundColor: isButtonActive
                      ? MaterialStateProperty.all(
                          Color.fromARGB(255, 241, 116, 107))
                      : MaterialStateProperty.all(
                          Color.fromARGB(255, 155, 155, 155)),
                  foregroundColor: isButtonActive
                      ? MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 255, 255))
                      : MaterialStateProperty.all(
                          Color.fromARGB(158, 255, 255, 255)),
                ),
              ),
            ),
          ]),
          centerTitle: true,
          backgroundColor: const Color(0xff36c182),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: quizData.finalQuizData.length,
                    itemBuilder: (context, index) => QuizData(
                          quiz: quizData.finalQuizData[index],
                          userId: quizData.userId,
                          authToken: quizData.authToken,
                          quizData: quizData.finalQuizData,
                        ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  QuizDataApi quizDataApiObj = QuizDataApi();
                  quizDataApiObj.updateQuizData(quizData.userId,
                      quizData.authToken, context, quizData.updatedQuizData);
                },
                child: const Text('Submit'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 48.0, vertical: 16)),
                  elevation: MaterialStateProperty.all(8),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
                  backgroundColor: MaterialStateProperty.all(Color(0xff5ECD9B)),
                  foregroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
