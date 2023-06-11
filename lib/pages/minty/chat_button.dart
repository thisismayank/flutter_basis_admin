import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/minty_api.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/pages/minty/list_chats.dart';
import 'package:provider/provider.dart';

class ChatButtons extends StatefulWidget {
  const ChatButtons({
    Key? key,
    required this.authToken,
    required this.rootContext,
  }) : super(key: key);
  final String authToken;
  final BuildContext rootContext;

  @override
  State<ChatButtons> createState() => _ChatButtonsState();
}

class _ChatButtonsState extends State<ChatButtons> {
  @override
  void initState() {
    super.initState();
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
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xff5ECD9B),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(-4, 4),
                  color: Color.fromARGB(0, 255, 255, 255)),
              BoxShadow(
                  blurRadius: 6,
                  offset: Offset(4, 4),
                  color: Color.fromARGB(48, 0, 0, 0))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.chat, color: Color.fromARGB(255, 219, 219, 219)),
              Text(" List of Chats",
                  style: TextStyle(
                      color: Color.fromARGB(255, 219, 219, 219),
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
      onTap: () =>
          mintyData.getAllChats(widget.authToken, widget.rootContext, 0, 500),
    );
  }
}
