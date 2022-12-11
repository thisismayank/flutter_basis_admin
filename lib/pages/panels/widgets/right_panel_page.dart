import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_graph_wrapper.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/search_results.dart';

class RightPanelPage extends StatefulWidget {
  const RightPanelPage(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext,
      required this.userInformation})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;
  final int userInformation;
  @override
  State<RightPanelPage> createState() => _RightPanelPageState();
}

class _RightPanelPageState extends State<RightPanelPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getBarChartData();
  }

  // void getBarChartData() async {

  //   PrepaidCardData prepaidCardData = PrepaidCardData();
  //   prepaidCardData.barGraphData(widget.authToken, widget.rootContext);
  // }

  Future<Widget> getBarGraphData() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.barGraphData(widget.authToken, widget.rootContext);

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: widget.userInformation == 1
          ? SearchResults(
              userData: widget.userData,
              rootContext: widget.rootContext,
              authToken: widget.authToken,
              userInformation: widget.userInformation)
          : widget.userInformation == 2
              ? PrepaidDataTable(
                  userData: widget.userData,
                  rootContext: widget.rootContext,
                  authToken: widget.authToken,
                  userInformation: widget.userInformation)
              : Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: const [
                          Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: TransactionssAnalytics()),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: RewardsAnalytics()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Flexible(
                        flex: 3,
                        child:
                            // Container()
                            FutureBuilder<Widget?>(
                                future: getBarGraphData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return BarGraphWrapper(
                                      rootContext: widget.rootContext,
                                      userId: widget.userData["_id"],
                                      authToken: widget.authToken,
                                    );
                                  } else {
                                    return const CircularProgressIndicator(
                                      color: Colors.green,
                                    );
                                  }
                                }))
                  ],
                ),
    );
  }
}
