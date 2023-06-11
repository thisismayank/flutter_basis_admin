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

class SelectableChat extends StatelessWidget {
  const SelectableChat({Key? key, required this.chat}) : super(key: key);
  final Map chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        CircleAvatar(radius: 24, backgroundImage: NetworkImage(chat["avatar"])),
        Expanded(
            child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(
                    '${chat["name"]} - ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${chat["email"]}',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w200),
                  )
                ]),
                const SizedBox(
                  height: 8,
                ),
                Opacity(
                  opacity: 0.64,
                  child: Text(
                    '${chat["messages"][0]["query"]}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          onTap: () =>
              Navigator.pushNamed(context, "/minty/messages", arguments: {
            "messages": chat["messages"],
            "name": chat["name"],
            "email": chat["email"],
            "avatar": chat["avatar"]
          }),
        )),
        Text(chat["createdAt"])
      ]),
    );
  }
}
