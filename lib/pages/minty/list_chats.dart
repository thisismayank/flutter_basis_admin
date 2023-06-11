import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/pages/minty/selectable_chat.dart';
import 'package:provider/provider.dart';

class ListChats extends StatelessWidget {
  const ListChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataPassed = ModalRoute.of(context)?.settings.arguments as Map;

    return Consumer<MintyDataStore>(builder: (context, chatData, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              'Chats - Total: ${chatData.countOfChats} - Unique: ${chatData.uniqueUserIds}'),
          centerTitle: true,
          backgroundColor: Color(0xff36c182),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: chatData.finalChatList.length,
                    itemBuilder: (context, index) =>
                        SelectableChat(chat: chatData.finalChatList[index])))
          ],
        ),
      );
    });
  }
}
