import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';

import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/ppc_activated_stats_line_chart.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/ppc_user_stats_pie_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/in_progress_users_bar_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/lin_graph_wrapper.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/line_chart.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class PrepaidCardUserAnalyticsPage extends StatelessWidget {
  const PrepaidCardUserAnalyticsPage(
      {Key? key,
      required this.authToken,
      required this.rootContext,
      required this.userId,
      required this.userData})
      : super(key: key);

  final String authToken;
  final BuildContext rootContext;
  final String userId;
  final Map userData;
  Future<Widget> getLineGraphData(double analyticsData) async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.getLineGraphData(
        authToken, rootContext, analyticsData);

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 200,
                maxHeight: MediaQuery.of(context).size.height - 10),
            child: IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                // color: Colors.green,
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    const Spacer(flex: 1),
                    Flexible(
                      flex: 4,
                      child: PpcUserStatsPieChart(
                          userData: userData,
                          authToken: authToken,
                          userId: userId,
                          rootContext: rootContext),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 6,
                      child: FutureBuilder<Widget?>(
                          future:
                              getLineGraphData(analyticsData.numberOfMonths),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return const LineGraphWrapper();
                            } else {
                              return Container(
                                width: ResponsiveLayout.isComputer(context)
                                    ? MediaQuery.of(context).size.width
                                    : MediaQuery.of(context).size.width - 50,
                                height:
                                    MediaQuery.of(context).size.height - 650,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                            }
                          }),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 6,
                      child: analyticsData.ipBasicDetails > 0
                          ? Container(
                              // height: 200,
                              margin: const EdgeInsets.all(8),
                              child: InProgressUsersBarChart(
                                  basicDetails: analyticsData.ipBasicDetails,
                                  pan: analyticsData.ipPan,
                                  address: analyticsData.ipAddress,
                                  otp: analyticsData.ipOtp),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: MediaQuery.of(context).size.height - 650,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(),
                            ),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
