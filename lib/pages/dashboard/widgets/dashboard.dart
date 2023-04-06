import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/logged_in_user_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/prepaid_card_user_analytics_ui.dart';

import 'package:flutter_application_6_provider/pages/webview/widgets/webview.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {Key? key,
      required this.userId,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final String userId;
  final String authToken;
  final BuildContext rootContext;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
      // return PrepaidCardUserAnalyticsPage(
      //     authToken: widget.authToken,
      //     rootContext: widget.rootContext,
      //     userId: widget.userId,
      //     userData: {});
    });
  }
}
