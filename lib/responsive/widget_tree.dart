import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/app_bar_widget.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/center_panel_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/drawer_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/left_bottom_panel_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/left_panel_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/left_top_panel_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/right_panel_page.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';

import 'package:flutter_application_6_provider/models/user_authentication.dart';

import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    final userDataPassed = ModalRoute.of(context)?.settings.arguments as Map;

    String authToken =
        '${userDataPassed["userData"]["_id"]},${userDataPassed["userData"]["token"]}';
    return Consumer<User>(builder: (context, user, child) {
      return Scaffold(
        appBar: PreferredSize(
          child: AppBarWidget(
            userData: userDataPassed["userData"],
            rootContext: context,
            authToken: authToken,
            userId: userDataPassed["userData"]["_id"],
          ),
          preferredSize: Size(double.infinity, 100),
        ),
        body: ResponsiveLayout(
            phone: CenterPanelPage(
              userData: userDataPassed["userData"],
              rootContext: context,
              authToken: authToken,
            ),
            computer: Row(
              children: [
                DrawerPage(
                  userData: userDataPassed["userData"],
                  rootContext: context,
                  authToken: authToken,
                ),
                // Column( children: [LeftTopPanelPage(
                //   userData: userDataPassed["userData"],
                //   rootContext: context,
                //   authToken: authToken,
                // ),LeftBottomPanelPage(
                //   userData: userDataPassed["userData"],
                //   rootContext: context,
                //   authToken: authToken,
                // )
                // ]),
                Expanded(
                    child: CenterPanelPage(
                  userData: userDataPassed["userData"],
                  rootContext: context,
                  authToken: authToken,
                )),
                Expanded(
                    child: RightPanelPage(
                  userData: userDataPassed["userData"],
                  rootContext: context,
                  authToken: authToken,
                ))
              ],
            )),
        drawer: DrawerPage(
          userData: userDataPassed["userData"],
          rootContext: context,
          authToken: authToken,
        ),
      );
    });
  }
}
