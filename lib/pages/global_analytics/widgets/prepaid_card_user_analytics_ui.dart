import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';

import 'package:flutter_application_6_provider/models/global_analytics.dart';
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
      required this.context,
      required this.userId})
      : super(key: key);

  final String authToken;
  final BuildContext context;
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

  void getData() async {
    // PrepaidCardData prepaidCardDataApi = PrepaidCardData();
    // await prepaidCardDataApi.getAllUsersWhoActivatedPowerCard(
    //     widget.authToken, widget.context, 0, 20);

    // Navigator.pushNamed(widget.context, "/prepaid/activated",
    //     arguments: {"authToken": widget.authToken});
  }

  Widget build(BuildContext context) {
    final String authToken = widget.authToken;
    int touchedIndex = -1;

    // final passedData = ModalRoute.of(context)?.settings.arguments as Map;
    // String authToken = passedData["authToken"];
    void getPrepaidStoreData() async {
      var uri =
          Uri.parse("https://api.getbasis.co/v6.4/admins/prepaid/user/data");
      var response = await http
          .get(uri, headers: {"Authorization": 'Bearer ${widget.authToken}'});
      Map responseData = jsonDecode(response.body);

      Provider.of<PrepaidDataStore>(context, listen: false)
          .setDataToPrepaidStore(responseData["results"]);

      Navigator.pushNamed(widget.context, "/prepaid",
          arguments: {"authToken": widget.authToken});
    }

    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return Column(
        children: [
          SizedBox(
              height: 300,
              width: 200,
              child: Stack(children: [
                // const SizedBox(height: 400),
                PieChart(PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (pieTouchResponse
                                ?.touchedSection!.touchedSectionIndex ==
                            2) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: 400,
                                    width: 100,
                                    child: Stack(children: [
                                      PieChart(
                                        PieChartData(
                                            centerSpaceRadius: 70,
                                            startDegreeOffset: -90,
                                            sections: [
                                              PieChartSectionData(
                                                  color:
                                                      const Color(0xFFE6F69D),
                                                  value: analyticsData
                                                      .ipBasicDetails,
                                                  title:
                                                      'Basic Details \n ${analyticsData.ipBasicDetails.toInt()}',
                                                  titleStyle: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  titlePositionPercentageOffset:
                                                      0.99,
                                                  radius: 50),
                                              PieChartSectionData(
                                                  color:
                                                      const Color(0xFFAADEA7),
                                                  value: analyticsData.ipPan,
                                                  title:
                                                      'PAN\n ${analyticsData.ipPan.toInt()}',
                                                  titleStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      backgroundColor:
                                                          Color.fromARGB(124,
                                                              255, 255, 255)),
                                                  titlePositionPercentageOffset:
                                                      0.99,
                                                  radius: 40),
                                              PieChartSectionData(
                                                  color: const Color(
                                                      0xFF64C2A6),
                                                  value: analyticsData
                                                      .ipAddress,
                                                  title:
                                                      'Address\n ${analyticsData.ipAddress.toInt()}',
                                                  titleStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      backgroundColor:
                                                          Color.fromARGB(124,
                                                              255, 255, 255)),
                                                  titlePositionPercentageOffset:
                                                      0.99,
                                                  radius: 30),
                                              PieChartSectionData(
                                                  color:
                                                      const Color(0xFF2D87BB),
                                                  value: analyticsData.ipOtp,
                                                  title:
                                                      'OTP\n ${analyticsData.ipOtp.toInt()}',
                                                  titleStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      backgroundColor:
                                                          Color.fromARGB(124,
                                                              255, 255, 255)),
                                                  titlePositionPercentageOffset:
                                                      0.99,
                                                  radius: 30),
                                            ]),
                                        swapAnimationDuration: Duration(
                                            milliseconds: 150), // Optional
                                        swapAnimationCurve: Curves.linear,
                                      ),
                                      Positioned.fill(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'In Progress\n${analyticsData.ccStateInProgress.toInt()}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ))
                                    ])
                                    // ],
                                    );
                              });
                        }
                        // setState(() {
                        //   if (!event.isInterestedForInteractions ||
                        //       pieTouchResponse == null ||
                        //       pieTouchResponse.touchedSection == null) {
                        //     touchedIndex = -1;
                        //     return;
                        //   }
                        //   touchedIndex = pieTouchResponse
                        //       .touchedSection!.touchedSectionIndex;
                        // });
                      },
                    ),
                    centerSpaceRadius: 70,
                    startDegreeOffset: -30,
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
                          ),
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
                            backgroundColor:
                                Color.fromARGB(160, 255, 255, 255)),
                        titlePositionPercentageOffset: 0.99,
                        radius: 30,
                      ),
                      PieChartSectionData(
                          color: Color.fromARGB(255, 187, 62, 62),
                          value: analyticsData.ccStateManualCheck,
                          title:
                              'Manual\n ${analyticsData.ccStateManualCheck.toInt()}',
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          titlePositionPercentageOffset: 0.99,
                          radius: 60),
                    ])),
                Positioned.fill(
                    child: Center(
                  child: GestureDetector(
                    onTap: () => {getPrepaidStoreData()},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Users\n${analyticsData.totalStates.toInt()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '+${analyticsData.ccYesterday}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                )),
              ])
              // ],
              ),
          SizedBox(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: PrepaidCardActivatedDataTable(
                authToken: widget.authToken,
                userId: widget.userId,
                contextRoot: widget.context),
          )
        ],
      );
    });
  }
}
