import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

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
              child: Image.asset("assets/images/google.png"),
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
        IconButton(
          color: Colors.white,
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.search),
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
              child: Image.asset("assets/images/google.png"),
            ),
          )
      ]),
    );
  }
}
