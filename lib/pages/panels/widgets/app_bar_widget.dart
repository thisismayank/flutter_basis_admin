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
      // color: Colors.red,
      color: const Color(0xff5ECD9B),
      child: Row(children: [
        if (ResponsiveLayout.isComputer(context))
          Container(
            margin: const EdgeInsets.all(0),
            // height: double.infinity,
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
                  padding: const EdgeInsets.all(8),
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
          Container(
            child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                iconSize: 30,
                color: Colors.white,
                icon: const Icon(Icons.menu)),
          ),
        if (ResponsiveLayout.isComputer(context))
          const SizedBox(
            width: 30,
          ),
        if (ResponsiveLayout.isComputer(context)) const Spacer(),
        Expanded(
          child: SearchBarForUserData(
              userData: widget.userData,
              userId: widget.userId,
              authToken: widget.authToken,
              rootContext: widget.rootContext),
        ),
        Container(
          margin: ResponsiveLayout.isComputer(context)
              ? const EdgeInsets.all(16)
              : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          height: double.infinity,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Color.fromARGB(213, 255, 255, 255),
                offset: Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 10)
          ], shape: BoxShape.circle),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                radius: ResponsiveLayout.isComputer(context) ? 50 : 20,
                child: ResponsiveLayout.isComputer(context)
                    ? Lottie.network(
                        "https://res.cloudinary.com/basis-static/raw/upload/v1661928856/Power%20Card/card_going_up.json",
                      )
                    : Lottie.network(
                        "https://res.cloudinary.com/basis-static/raw/upload/v1661928856/Power%20Card/card_going_up.json",
                        height: 40),
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
