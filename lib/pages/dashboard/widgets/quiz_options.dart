import 'package:flutter/material.dart';

class QuizOptions extends StatefulWidget {
  const QuizOptions(
      {Key? key,
      required this.quizOptions,
      required this.quiz,
      required this.onQuizOptionsChange,
      required this.onQuizAnswerChange})
      : super(key: key);
  final List quizOptions;
  final Map quiz;
  final ValueChanged<List> onQuizOptionsChange;
  final ValueChanged<String> onQuizAnswerChange;

  @override
  State<QuizOptions> createState() => _QuizOptionsState();
}

class _QuizOptionsState extends State<QuizOptions> {
  late String quizAnswer; // Define quizAnswer as a non-final variable
  late List quizOptionsHere;
  @override
  void initState() {
    super.initState();
    quizAnswer = widget.quiz['answer'];
    quizOptionsHere = widget.quizOptions;
    // Initialize quizAnswer in initState
  }

  @override
  Widget build(BuildContext context) {
    // var quizOptionsHere = widget.quizOptions;
    var quizId = widget.quiz['_id'];
    var optionController = TextEditingController();

    void optionUpdate(String oldValue) {
      print(optionController.text.toString());

      for (var i = 0; i < quizOptionsHere.length; i++) {
        var op = widget.quizOptions[i];
        if (op.toString().trim() == oldValue.trim()) {
          setState(() {
            quizOptionsHere[i] = optionController.text.toString();
          });
        }
      }

      widget.onQuizOptionsChange(
          quizOptionsHere); // Invoke the callback function to update quizOptions in the parent
      setState(() {
        quizAnswer = optionController.text.toString(); // Update quizAnswer
      });
      if (quizAnswer.toString().trim() == oldValue.trim()) {
        widget.onQuizAnswerChange(optionController.text.toString());
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: quizOptionsHere
          .map((option) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Radio(
                      activeColor: Color(0xff5ECD9B),
                      value: option.toString(),
                      groupValue: quizAnswer,
                      onChanged: (valueOfNewAnswer) {
                        setState(() {
                          quizAnswer =
                              valueOfNewAnswer.toString(); // Update quizAnswer
                        });
                        widget.onQuizAnswerChange(valueOfNewAnswer.toString());
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      option,
                      style: TextStyle(
                        fontWeight: quizAnswer == option
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      child: InkWell(
                        child: Icon(
                          Icons.edit,
                          size: 14,
                          color: widget.quiz["answer"] == option
                              ? Color(0xff5ECD9B)
                              : Colors.black87,
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            optionController.text = option;
                            return Container(
                              child: AlertDialog(
                                title: SelectableText('$option'),
                                content: TextField(
                                  controller: optionController,
                                  decoration: InputDecoration(hintText: option),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      optionUpdate(option);
                                      return Navigator.pop(context);
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
