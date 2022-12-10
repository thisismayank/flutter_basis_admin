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

class LeftBottomPanelPage extends StatefulWidget {
  const LeftBottomPanelPage(
      {Key? key,
      required this.authToken,
      required this.rootContext,
      required this.userData})
      : super(key: key);

  final String authToken;
  final BuildContext rootContext;
  final Map userData;

  @override
  State<LeftBottomPanelPage> createState() => _LeftBottomPanelPageState();
}

class _LeftBottomPanelPageState extends State<LeftBottomPanelPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return SizedBox(
          height: 100,
          // width: MediaQuery.of(context).size.width,
          child: Container()
          // PrepaidCardActivatedDataTable(
          //     authToken: widget.authToken,
          //     userId: widget.userData["_id"],
          //     rootContext: widget.rootContext),
          );
    });
  }
}
