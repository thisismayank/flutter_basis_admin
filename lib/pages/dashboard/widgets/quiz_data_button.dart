import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/minty_api.dart';
import 'package:flutter_application_6_provider/apis/quiz_api.dart';

import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/quiz.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/quiz_data_wrapper.dart';
import 'package:flutter_application_6_provider/pages/minty/list_chats.dart';
import 'package:provider/provider.dart';

class DailyQuizDataButton extends StatefulWidget {
  const DailyQuizDataButton({
    Key? key,
    required this.userId,
    required this.authToken,
    required this.rootContext,
  }) : super(key: key);
  final String userId;
  final String authToken;
  final BuildContext rootContext;

  @override
  State<DailyQuizDataButton> createState() => _DailyQuizDataButtonState();
}

class _DailyQuizDataButtonState extends State<DailyQuizDataButton> {
  @override
  QuizDataApi quizDataApi = QuizDataApi();

  void initState() {
    super.initState();
    print('HERE WE ARE');
    quizDataApi.getQuizData(
        widget.userId, widget.authToken, widget.rootContext, 0, 500);
    // getAllChatsForMinty();
  }

  // void getAllChatsForMinty() async {
  //   PrepaidCardData prepaidCardData = PrepaidCardData();

  //   prepaidCardData.getAllChats(
  //       widget.authToken, widget.rootContext, 0, 500);

  //   Navigator.pushNamed(context, "/minty", arguments: {
  //     "context": widget.rootContext,
  //     "authToken": widget.authToken
  //   });
  // }

  Widget build(BuildContext context) {
    MintyData mintyData = MintyData();
    QuizDataApi quizData = QuizDataApi();
    return Consumer<QuizDataStore>(builder: (context, quizData, child) {
      print(
          'quizData.finalQuizData.isNotEmpty ${quizData.finalQuizData.isNotEmpty}');
      print('QUIZ DATA STORE $quizData');
      return InkWell(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(-4, 4),
                    color: Color(0xff5ECD9B),
                  ),
                  BoxShadow(
                    blurRadius: 6,
                    offset: Offset(4, 4),
                    color: Color(0xff5ECD9B),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.quiz,
                      color: quizData.finalQuizData.isNotEmpty
                          ? Color(0xff5ECD9B)
                          : Colors.red),
                  Text(" Quiz Data ",
                      style: TextStyle(
                          color: quizData.finalQuizData.isNotEmpty
                              ? Color(0xff5ECD9B)
                              : Colors.red,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0),
                    child: quizData.finalQuizData.isNotEmpty
                        ? const Icon(Icons.check_circle,
                            color: Color(0xff5ECD9B))
                        : const Icon(Icons.dangerous, color: Colors.red),
                  )
                ],
              ),
            ),
          ),
          onTap: () => quizData.finalQuizData.isNotEmpty == true
              ? Navigator.pushNamed(context, "/quiz", arguments: {
                  "context": context,
                  "authToken": widget.authToken,
                  "userId": widget.userId,
                })
              : quizDataApi.syncQuizData(
                  widget.userId, widget.authToken, context));
    });
  }
}
