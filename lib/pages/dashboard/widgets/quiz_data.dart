import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/apis/quiz_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/quiz.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/quiz_options.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/quiz_options_data.dart';
import 'package:flutter_application_6_provider/pages/minty/chat_messages_wrapper.dart';
import 'package:provider/provider.dart';

class QuizData extends StatefulWidget {
  QuizData(
      {Key? key,
      required this.userId,
      required this.authToken,
      required this.quizData,
      required this.quiz})
      : super(key: key);

  final Map quiz;
  final String userId;
  final String authToken;
  final List quizData;

  @override
  State<QuizData> createState() => _QuizDataState();
}

class _QuizDataState extends State<QuizData> {
  QuizDataApi quizDataApi = QuizDataApi();
  late String quizQuestion;

  @override
  void initState() {
    super.initState();
    quizQuestion = widget.quiz["question"];

    // Initialize quizAnswer in initState
  }

  Widget build(BuildContext context) {
    var questionController = TextEditingController();

    void updateTheQuizData() async {}
    List completeQuizData = widget.quizData;
    List quizOptions = widget.quiz["options"];
    String quizAnswer = widget.quiz["answer"];

    void finalQuizDataChange() async {
      for (var i = 0; i < completeQuizData.length; i++) {
        Map quizObj = completeQuizData[i];
        if (quizObj["_id"].toString() == widget.quiz["_id"].toString()) {
          completeQuizData[i]["question"] = quizQuestion;
          completeQuizData[i]["answer"] = quizAnswer;
          completeQuizData[i]["options"] = quizOptions;
        }
      }

      Provider.of<QuizDataStore>(context, listen: false)
          .updateQuizDataStore(completeQuizData);
    }

    void handleQuizOptionsChange(List newQuizOptions) {
      setState(() {
        quizOptions = newQuizOptions;
      });
      finalQuizDataChange();
    }

    void handleQuizAnswerChange(String newQuizAnswer) {
      setState(() {
        quizAnswer = newQuizAnswer;
      });
      finalQuizDataChange();
    }

    handleQuizQuestionChange() {
      setState(() {
        quizQuestion = questionController.text.toString();
      });
      finalQuizDataChange();
    }

    void questionUpdate() async {
      print(questionController.text.toString());
      // var uri = Uri.parse("https://api.getbasis.co/v6.4/users/email");
      // var response = await http
      //     .post(uri, body: {"email": emailController.text.toString()});

      // Map responseData = jsonDecode(response.body);

      // Navigator.pushNamed(context, "/otp", arguments: {
      //   "email": emailController.text.toString(),
      //   "token": responseData["results"]["token"]
      // });
    }

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InkWell(
          //   onTap: () => quizDataApi.updateQuizData(
          //       userId, authToken, quiz["_id"], quizData, context, 0, 0),
          //   child: Text(
          //     quiz["question"],
          //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //   ),
          // ),
          Row(children: [
            Text(
              quizQuestion,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            InkWell(
                child: Icon(Icons.edit, size: 16),
                onTap: () => [
                      showDialog(
                          context: context,
                          builder: (context) {
                            questionController.text = quizQuestion;
                            return Container(
                                child: AlertDialog(
                              title:
                                  SelectableText('${widget.quiz["question"]}'),
                              content: TextField(
                                controller: questionController,
                                decoration: InputDecoration(
                                    hintText: widget.quiz["question"]),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: (() {
                                      handleQuizQuestionChange();
                                      return Navigator.pop(context);
                                    }),
                                    child: Text("Submit"))
                              ],
                            )
                                // AlertDialog(
                                //   title: Text(quiz["question"]),
                                //   actions: [
                                //     TextButton(
                                //         onPressed: (() => Navigator.pop(context)),
                                //         child: Text("Submit"))
                                //   ],
                                // ),
                                );
                          })
                    ])
          ]),
          const SizedBox(
            height: 10,
          ),
          QuizOptions(
            quizOptions: quizOptions,
            onQuizOptionsChange: handleQuizOptionsChange,
            onQuizAnswerChange: handleQuizAnswerChange,
            quiz: widget.quiz,
          ),
        ],
      ),
    );
  }
}
