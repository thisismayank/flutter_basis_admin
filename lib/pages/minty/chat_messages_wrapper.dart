import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/pages/minty/chat_messages.dart';
import 'package:provider/provider.dart';

class ChatMessagesWrapper extends StatelessWidget {
  const ChatMessagesWrapper({Key? key, required this.messages})
      : super(key: key);
  final Map messages;
  @override
  Widget build(BuildContext context) {
    // print('INSIDE WRAPPER $messages');
    // print('INSIDE WRAPPER messages ${messages["messages"]}');
    // print('INSIDE WRAPPER messages ${messages["messages"]}');
    List finalMessageList = messages["messages"];
    String name = messages["name"];
    String email = messages["email"];
    String avatar = messages["avatar"];

    // print('finalList WRAPPER ${finalList}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff36c182),
        centerTitle: true,
        title: Text('$name - $email'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: finalMessageList.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChatMessages(
                            message: finalMessageList[index] ?? {}),
                      ))))
        ],
      ),
    );
  }
}
