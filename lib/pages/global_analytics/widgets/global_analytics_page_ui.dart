import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/prepaid_card_user_analytics_ui.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';

import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GlobalAnalyticsPage extends StatelessWidget {
  const GlobalAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passedData = ModalRoute.of(context)?.settings.arguments as Map;

    String userId = passedData["userData"]["userData"]["_id"];
    String authToken = passedData["authToken"];
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return MaterialApp(
          home: Scaffold(
              // backgroundColor: const Color.fromARGB(255, 228, 182, 182),
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Power Card Analytics'),
                backgroundColor: const Color(0xff36c182),
              ),
              body: Container(
                child: CarouselSlider(
                  items: [
                    PrepaidCardUserAnalyticsPage(
                        authToken: authToken, context: context, userId: ""),
                    TransactionssAnalytics(),
                    RewardsAnalytics(),
                  ],
                  options: CarouselOptions(
                    viewportFraction: 2.0,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              )));
    });
  }
}
