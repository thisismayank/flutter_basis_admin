import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';

import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/ppc_user_stats_pie_chart.dart';
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
      required this.userId})
      : super(key: key);

  final String authToken;
  final BuildContext rootContext;
  final String userId;

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
      return Container(
        margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Column(
          children: [
            SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: PpcUserStatsPieChart(
                    authToken: widget.authToken,
                    userId: widget.userId,
                    rootContext: widget.rootContext)),
            SizedBox(
              height: 300,
              // width: MediaQuery.of(context).size.width,
              child: PrepaidCardActivatedDataTable(
                  authToken: widget.authToken,
                  userId: widget.userId,
                  rootContext: widget.rootContext),
            )
          ],
        ),
      );
    });
  }
}
