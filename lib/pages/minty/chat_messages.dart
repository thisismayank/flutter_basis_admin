import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key, required this.message}) : super(key: key);
  final Map message;
  @override
  Widget build(BuildContext context) {
    // return Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //         margin: EdgeInsets.only(top: 8),
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             color: Colors.green, borderRadius: BorderRadius.circular(30)),
    //         child: Text('${message["query"]}',
    //             style: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 14,
    //               decoration: TextDecoration.none,
    //               overflow: TextOverflow.visible,
    //             )),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Expanded(
    //       child: Container(
    //         margin: EdgeInsets.only(top: 8),
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             color: Colors.lightBlueAccent,
    //             borderRadius: BorderRadius.circular(30)),
    //         child: Text('${message["response"]}',
    //             style: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 14,
    //               decoration: TextDecoration.none,
    //               overflow: TextOverflow.visible,
    //             )),
    //       ),
    //     )
    //   ],
    // );
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: Text('${message["query"]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.visible,
                    )),
              ),
            ),
            Expanded(
              child: Container(),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(),
              // child: IconButton(
              //   icon: const Icon(Icons.thumb_down),
              //   tooltip: 'Report',
              //   onPressed: () {},
              // ),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  // width: 400,
                  decoration: BoxDecoration(
                      color: const Color(0xff768EE7),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text('${message["response"]}',
                      maxLines: 10,
                      softWrap: true,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 14,
                        overflow: TextOverflow.visible,
                      ))),
            ),
          ],
        ),
      ],
    );
  }
}
