import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/logged_in_user_ui.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;

  Widget build(BuildContext context) {
    // print('here ${userData}');
    return Consumer<User>(builder: (context, user, child) {
      return Container(
        width: 250,
        child: Drawer(
            backgroundColor: Color(0xff5ECD9B),
            child: LoggedInUserData(
                userId: userData["_id"],
                authToken: authToken,
                rootContext: rootContext,
                user: user,
                backgroundColor: Color(0xff5ECD9B))),
      );
    });
  }
}
