import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/search_bar_for_user_data.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext,
      required this.userId})
      : super(key: key);

  final Map userData;
  final String authToken;
  final BuildContext rootContext;
  final String userId;
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff36c182),
      child: Row(children: [
        if (ResponsiveLayout.isComputer(context))
          Container(
            margin: EdgeInsets.all(16),
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(213, 255, 255, 255),
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                    blurRadius: 10)
              ],
              shape: BoxShape.rectangle,
            ),
            child: Stack(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  padding: EdgeInsets.all(8),
                  // color: Color.fromARGB(0, 188, 178, 178),
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.rectangle,
                  //   color: Color.fromARGB(0, 236, 236, 236),
                  // ),
                  // child: CircleAvatar(
                  //   backgroundColor: Color.fromARGB(0, 236, 236, 236),
                  //   radius: 60,
                  child: Image.network(
                      "https://res.cloudinary.com/basis-static/image/upload/v1609946823/logos/Basis_Green_Logo_2x.png"),
                  // ),
                ),
                Positioned.fill(
                    child: Lottie.network(
                        "https://res.cloudinary.com/basis-static/raw/upload/v1666247927/Power%20Card/confetti.json"))
              ],
            ),
          )
        else
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              iconSize: 30,
              color: Colors.white,
              icon: const Icon(Icons.menu)),
        const SizedBox(
          width: 30,
        ),
        const Spacer(),
        Expanded(
          child: SearchBarForUserData(
              userId: widget.userId,
              authToken: widget.authToken,
              rootContext: widget.rootContext),
        ),
        // Stack(children: [
        //   IconButton(
        //       color: Colors.white,
        //       iconSize: 30,
        //       onPressed: () {},
        //       icon: Icon(Icons.notifications_none_outlined)),
        //   const Positioned(
        //       right: 6,
        //       top: 6,
        //       child: CircleAvatar(
        //         backgroundColor: Colors.pink,
        //         radius: 8,
        //         child: Text(
        //           "3",
        //           style: TextStyle(fontSize: 10, color: Colors.white),
        //         ),
        //       ))
        // ]),
        if (!ResponsiveLayout.isPhone((context)))
          Container(
            margin: const EdgeInsets.all(16),
            height: double.infinity,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(213, 255, 255, 255),
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 10)
            ], shape: BoxShape.circle),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(0, 255, 255, 255),
                  radius: 50,
                  child: Lottie.network(
                    "https://res.cloudinary.com/basis-static/raw/upload/v1661928856/Power%20Card/card_going_up.json",
                  ),
                ),
                Positioned.fill(
                    child: Lottie.network(
                        "https://res.cloudinary.com/basis-static/raw/upload/v1666247927/Power%20Card/confetti.json"))
              ],
            ),
          )
      ]),
    );
  }
}
