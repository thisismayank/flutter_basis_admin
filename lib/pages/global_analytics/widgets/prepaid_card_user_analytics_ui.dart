import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';

import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/ppc_user_stats_pie_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/in_progress_users_bar_chart.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class PrepaidCardUserAnalyticsPage extends StatefulWidget {
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

  @override
  State<PrepaidCardUserAnalyticsPage> createState() =>
      _PrepaidCardUserAnalyticsPageState();
}

class _PrepaidCardUserAnalyticsPageState
    extends State<PrepaidCardUserAnalyticsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return Expanded(
        child: Column(
          children: [
            // const Spacer(
            //   flex: 1,
            // ),
            Flexible(
              flex: 3,
              child: Container(
                // padding: EdgeInsets.all(32),
                child: Row(
                  children: [
                    Expanded(
                      child: PpcUserStatsPieChart(
                          userData: widget.userData,
                          authToken: widget.authToken,
                          userId: widget.userId,
                          rootContext: widget.rootContext),
                    ),
                    Expanded(
                      child: analyticsData.ipBasicDetails > 0
                          ? InProgressUsersBarChart(
                              basicDetails: analyticsData.ipBasicDetails,
                              pan: analyticsData.ipPan,
                              address: analyticsData.ipAddress,
                              otp: analyticsData.ipOtp)
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
            // const Spacer(
            //   flex: 1,
            // ),
            Flexible(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(-4, 4),
                          color: Color.fromARGB(0, 255, 255, 255)),
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(8, 8),
                          color: Color.fromARGB(48, 0, 0, 0))
                    ]),
                child: PrepaidCardActivatedDataTable(
                    userData: widget.userData,
                    authToken: widget.authToken,
                    userId: widget.userId,
                    rootContext: widget.rootContext),
              ),
            ),
          ],
        ),
      );
    });
  }
}
