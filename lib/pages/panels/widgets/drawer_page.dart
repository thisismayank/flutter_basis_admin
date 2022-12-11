import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/logged_in_user_ui.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;
  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      return Container(
        width: 250,
        child: Drawer(
            backgroundColor: Color(0xff5ECD9B),
            child: LoggedInUserData(
                userId: widget.userData["_id"],
                authToken: widget.authToken,
                rootContext: widget.rootContext,
                user: user,
                backgroundColor: Color(0xff5ECD9B))),
      );
    });
  }
}
