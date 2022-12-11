import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/dashboard.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/global_analytics_page_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/prepaid_card_user_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/mobile_trnsactions_page.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/email.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/otp.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

class CenterPanelPage extends StatefulWidget {
  const CenterPanelPage(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;

  // final Array userData;
  @override
  State<CenterPanelPage> createState() => _CenterPanelPageState();
}

class _CenterPanelPageState extends State<CenterPanelPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGlobalAnalyticsDataForAdmin();
  }

  void getGlobalAnalyticsDataForAdmin() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.getGlobalAnalyticsDataForAdmin(
        widget.authToken, widget.rootContext);
  }

  Widget build(BuildContext context) {
    if (widget.authToken.isEmpty) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/");
    }
    return Consumer<User>(builder: (context, user, child) {
      return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (ResponsiveLayout.isComputer(context))
            Container(
              color: const Color(0xff5ECD9B),
              width: 30,
              height: 30,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50))),
              ),
            ),
          SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 140,
            // child: Expanded(
            child: ResponsiveLayout.isComputer(context)
                ? PrepaidCardUserAnalyticsPage(
                    rootContext: widget.rootContext,
                    userId: widget.userData["_id"],
                    authToken: widget.authToken,
                    userData: widget.userData)
                : PageView(
                    controller: PageController(initialPage: 0),
                    children: [
                        PrepaidCardUserAnalyticsPage(
                            rootContext: widget.rootContext,
                            userId: widget.userData["_id"],
                            authToken: widget.authToken,
                            userData: widget.userData),
                        MobileTransactionsPage(
                          rootContext: widget.rootContext,
                          authToken: widget.authToken,
                          userData: widget.userData,
                          userInformation: 0,
                        ),
                        RewardsAnalytics()
                      ]),
            // ),
          ))
        ]),
      );
    });
  }
}
