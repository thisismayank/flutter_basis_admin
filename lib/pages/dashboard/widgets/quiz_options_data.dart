import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/pages/minty/chat_messages_wrapper.dart';
import 'package:provider/provider.dart';

class QuizOptionsData extends StatelessWidget {
  const QuizOptionsData({Key? key, required this.quizOption}) : super(key: key);
  final String quizOption;
  @override
  Widget build(BuildContext context) {
    print('quiz options $quizOption');
    return Text(quizOption);
  }
}
