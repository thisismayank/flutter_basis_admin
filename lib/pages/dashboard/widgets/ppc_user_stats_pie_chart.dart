import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';

import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class PpcUserStatsPieChart extends StatelessWidget {
  const PpcUserStatsPieChart(
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
  Widget build(BuildContext context) {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    int touchedIndex = -1;

    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(children: [
          // const SizedBox(height: 400),
          PieChart(PieChartData(
              centerSpaceRadius: ResponsiveLayout.isComputer(context) ? 70 : 60,
              startDegreeOffset:
                  ResponsiveLayout.isComputer(context) ? -45 : 40,
              sections: [
                PieChartSectionData(
                    color: const Color(0xFFF2BC5E),
                    value: analyticsData.ccStateActivated,
                    title:
                        'Activated \n ${analyticsData.ccStateActivated.toInt()}',
                    titleStyle: TextStyle(
                        fontSize: touchedIndex == 0 ? 16 : 12,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white),
                    titlePositionPercentageOffset: 0.99,
                    radius: 40),
                PieChartSectionData(
                    color: Color.fromARGB(255, 252, 241, 23),
                    value: analyticsData.ccPhysicallyActivated,
                    title:
                        'Physically Activated \n ${analyticsData.ccPhysicallyActivated.toInt()}',
                    titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white),
                    titlePositionPercentageOffset: 0.99,
                    radius: 40),
                PieChartSectionData(
                  color: Color.fromARGB(255, 94, 164, 230),
                  value: analyticsData.ccStateInProgress,
                  title:
                      'In Progress\n ${analyticsData.ccStateInProgress.toInt()}',
                  titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Color.fromARGB(160, 255, 255, 255)),
                  titlePositionPercentageOffset: 0.99,
                  radius: 30,
                ),
                PieChartSectionData(
                    color: Color.fromARGB(255, 252, 38, 23),
                    value: analyticsData.ccStateRejected,
                    title:
                        'Rejected \n ${analyticsData.ccStateRejected.toInt()}',
                    titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white),
                    titlePositionPercentageOffset: 0.99,
                    radius: 20),
                PieChartSectionData(
                    color: Color.fromARGB(255, 64, 187, 62),
                    value: analyticsData.ccStateManualCheck,
                    title:
                        'Manual\n ${analyticsData.ccStateManualCheck.toInt()}',
                    titleStyle: TextStyle(
                        fontSize:
                            ResponsiveLayout.isComputer(context) ? 12 : 10,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white),
                    titlePositionPercentageOffset: 0.99,
                    radius: ResponsiveLayout.isComputer(context) ? 50 : 80),
              ])),
          Positioned.fill(
              child: Center(
            child: InkWell(
              onTap: () => {
                prepaidCardData.getPrepaidStoreData(
                    userId, userData, authToken, rootContext)
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Tooltip(
                    message:
                        "Total users who have started and are eligible for the flow\n activated + manual +in progress",
                    child: Text(
                      'Total Users\n${analyticsData.totalStates.toInt()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tooltip(
                    message:
                        "Number of users who activated their card\n in the past 24 hours",
                    child: Text(
                      '+${analyticsData.ccYesterday}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ]),
      );

      // ],
    });
  }
}
