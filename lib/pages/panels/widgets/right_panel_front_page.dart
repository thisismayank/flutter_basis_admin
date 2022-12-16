import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_graph_wrapper.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/line_double_chart_wrapper.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/search_results.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';

class RightPanelFrontPage extends StatefulWidget {
  const RightPanelFrontPage(
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
  State<RightPanelFrontPage> createState() => _RightPanelFrontPageState();
}

class _RightPanelFrontPageState extends State<RightPanelFrontPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getBarChartData();
  }

  Future<Widget> getBarGraphData() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.barGraphData(widget.authToken, widget.rootContext);

    return Container();
  }

  Future<Widget> getLineDoubleGraphData() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();

    await prepaidCardData.getLineDoubleChartData(
        widget.authToken, widget.rootContext);
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
                : SingleChildScrollView(
                    child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 200,
                        maxHeight: MediaQuery.of(context).size.height - 10),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 30,
                        // ),
                        const Spacer(flex: 1),
                        Flexible(
                          flex: 4,
                          child: Row(
                            children: [
                              const Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: TransactionssAnalytics()),
                              ResponsiveLayout.isComputer(context)
                                  ? const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: RewardsAnalytics())
                                  : Container(),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 32,
                        // ),
                        const Spacer(flex: 1),
                        Flexible(
                            flex: 6,
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
                                    })),
                        Flexible(
                            flex: 6,
                            child:
                                // Container()
                                FutureBuilder<Widget?>(
                                    future: getLineDoubleGraphData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return const LineDoubleChartWrapper();
                                      } else {
                                        return const CircularProgressIndicator(
                                          color: Colors.green,
                                        );
                                      }
                                    })),
                        const Spacer(flex: 1)
                      ],
                    ),
                  )));
  }
}
