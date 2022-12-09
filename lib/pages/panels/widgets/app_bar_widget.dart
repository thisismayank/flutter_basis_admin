import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/search_bar_for_user_data.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

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
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 10)
            ], shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 30,
              child: Image.network(widget.userData["avatar"]),
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
        Spacer(),
        Expanded(
          child: SearchBarForUserData(
              userId: widget.userId,
              authToken: widget.authToken,
              rootContext: widget.rootContext),
        ),
        Stack(children: [
          IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {},
              icon: Icon(Icons.notifications_none_outlined)),
          const Positioned(
              right: 6,
              top: 6,
              child: CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 8,
                child: Text(
                  "3",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ))
        ]),
        if (!ResponsiveLayout.isPhone((context)))
          Container(
            margin: EdgeInsets.all(16),
            height: double.infinity,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 10)
            ], shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 30,
              backgroundImage: NetworkImage(
                widget.userData["avatar"],
              ),
            ),
          )
      ]),
    );
  }
}
