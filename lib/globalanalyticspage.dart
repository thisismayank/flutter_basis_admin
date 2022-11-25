import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_6_provider/globalanalytics.dart';
import 'package:flutter_application_6_provider/prepaiddatastore.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class GlobalAnalyticsPage extends StatefulWidget {
  const GlobalAnalyticsPage({Key? key}) : super(key: key);

  @override
  State<GlobalAnalyticsPage> createState() => _GlobalAnalyticsPageState();
}

class _GlobalAnalyticsPageState extends State<GlobalAnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    int touchedIndex = -1;

    final passedData = ModalRoute.of(context)?.settings.arguments as Map;
    String authToken = passedData["authToken"];
    void getPrepaidStoreData() async {
      var uri =
          Uri.parse("https://api.getbasis.co/v6.4/admins/prepaid/user/data");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
      Map responseData = jsonDecode(response.body);

      Provider.of<PrepaidDataStore>(context, listen: false)
          .setDataToPrepaidStore(responseData["results"]);

      Navigator.pushNamed(context, "/prepaid",
          arguments: {"authToken": authToken});
    }

    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return MaterialApp(
          home: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 228, 182, 182),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Power Card Analytics'),
          backgroundColor: const Color(0xff36c182),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(children: [
            // const Text("Global Analytics",
            //     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 200,
                width: 100,
                child: Stack(children: [
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
                                                        'Basic Details \n ${analyticsData.ipBasicDetails}',
                                                    titleStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    titlePositionPercentageOffset:
                                                        0.99,
                                                    radius: 50),
                                                PieChartSectionData(
                                                    color:
                                                        const Color(0xFFAADEA7),
                                                    value: analyticsData.ipPan,
                                                    title:
                                                        'PAN\n ${analyticsData.ipPan}',
                                                    titleStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        backgroundColor:
                                                            Color.fromARGB(124,
                                                                255, 255, 255)),
                                                    titlePositionPercentageOffset:
                                                        0.99,
                                                    radius: 40),
                                                PieChartSectionData(
                                                    color:
                                                        const Color(0xFF64C2A6),
                                                    value:
                                                        analyticsData.ipAddress,
                                                    title:
                                                        'Address\n ${analyticsData.ipAddress}',
                                                    titleStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        'OTP\n ${analyticsData.ipOtp}',
                                                    titleStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              'In Progress\n${analyticsData.ccStateInProgress}',
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
                                'Activated \n ${analyticsData.ccStateActivated}',
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
                                'Physically Activated \n ${analyticsData.ccPhysicallyActivated}',
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
                              'In Progress\n ${analyticsData.ccStateInProgress}',
                          titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              backgroundColor:
                                  Color.fromARGB(160, 255, 255, 255)),
                          titlePositionPercentageOffset: 0.99,
                          radius: 30,
                        ),
                        PieChartSectionData(
                            color: const Color(0xFF633EBB),
                            value: analyticsData.ccStateManualCheck,
                            title:
                                'Manual\n ${analyticsData.ccStateManualCheck}',
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
                            'Users\n${analyticsData.totalStates}',
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
                  ))
                ])
                // ],
                ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 200,
                width: 100,
                child: Stack(children: [
                  PieChart(
                    PieChartData(
                        centerSpaceRadius: 50,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(
                              color: const Color(0xFFEA5F89),
                              value: analyticsData.rewardLocked,
                              title: 'Locked \n ${analyticsData.rewardLocked}',
                              titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor:
                                      Color.fromARGB(164, 255, 255, 255)),
                              titlePositionPercentageOffset: 0.99,
                              radius: 40),
                          PieChartSectionData(
                              color: const Color(0xFFF7B7A3),
                              value: analyticsData.rewardRedeemed,
                              title:
                                  'Redeemed\n ${analyticsData.rewardRedeemed}',
                              titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor:
                                      Color.fromARGB(124, 255, 255, 255)),
                              titlePositionPercentageOffset: 0.99,
                              radius: 30),
                        ]),
                    swapAnimationDuration:
                        Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear,
                  ),
                  Positioned.fill(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rewards\n${analyticsData.totalRewards}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
                ])
                // ],
                ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 200,
                width: 100,
                child: Stack(children: [
                  PieChart(PieChartData(
                      centerSpaceRadius: 70,
                      startDegreeOffset: -90,
                      sections: [
                        PieChartSectionData(
                            color: const Color(0xFF26E5FF),
                            value: analyticsData.txnWallet,
                            title: 'Wallet Txns\n ₹${analyticsData.txnWallet}',
                            titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white),
                            titlePositionPercentageOffset: 0.99,
                            radius: 40),
                        PieChartSectionData(
                            color: Color.fromARGB(255, 182, 218, 222),
                            value: analyticsData.txnCashbacks,
                            title: 'Cashbacks\n ₹${analyticsData.txnCashbacks}',
                            titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                backgroundColor:
                                    Color.fromARGB(164, 255, 255, 255)),
                            titlePositionPercentageOffset: 0.99,
                            radius: 60),
                        PieChartSectionData(
                            color: const Color(0xFFEE2727),
                            value: analyticsData.txnTransactions,
                            title: 'Txns\n ₹${analyticsData.txnTransactions}',
                            titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white),
                            titlePositionPercentageOffset: 0.99,
                            radius: 30),
                      ])),
                  Positioned.fill(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Text(
                      //   "Total",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 20),
                      // ),
                      Text(
                        'Transactions\n₹${analyticsData.totalTransactions}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ))
                ])
                // ],
                ),
          ])),
        ),
      ));
    });
  }
}
