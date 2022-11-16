import 'package:flutter/material.dart';

import 'package:flutter_application_6_provider/globalanalytics.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class GlobalAnalyticsPage extends StatelessWidget {
  const GlobalAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      print('HERRRRREEEE');
      print(analyticsData.ccStateActivated);
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
                      centerSpaceRadius: 70,
                      startDegreeOffset: -90,
                      sections: [
                        PieChartSectionData(
                            color: const Color(0xFFAADEA7),
                            value: analyticsData.ccStateActivated,
                            title:
                                'Activated \n ${analyticsData.ccStateActivated}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            titlePositionPercentageOffset: 0.99,
                            radius: 40),
                        PieChartSectionData(
                            color: const Color(0xFFFEAE65),
                            value: analyticsData.ccStateInProgress,
                            title:
                                'In Progress\n ${analyticsData.ccStateInProgress}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            titlePositionPercentageOffset: 0.99,
                            radius: 30),
                        PieChartSectionData(
                            color: const Color(0xFF64C2A6),
                            value: analyticsData.ccStateManualCheck,
                            title:
                                'Manual\n ${analyticsData.ccStateManualCheck}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            titlePositionPercentageOffset: 0.99,
                            radius: 20),
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
                        'Users\n${analyticsData.totalStates}',
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
                            color: const Color(0xFFEA5F89),
                            value: analyticsData.rewardLocked,
                            title: 'Locked \n ${analyticsData.rewardLocked}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            titlePositionPercentageOffset: 0.99,
                            radius: 40),
                        PieChartSectionData(
                            color: const Color(0xFFF7B7A3),
                            value: analyticsData.rewardRedeemed,
                            title: 'Redeemed\n ${analyticsData.rewardRedeemed}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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
                        'Rewards\n${analyticsData.totalRewards}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
                ])
                // ],
                ),
            SizedBox(
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
                            ),
                            titlePositionPercentageOffset: 0.99,
                            radius: 40),
                        PieChartSectionData(
                            color: const Color(0xFFFFCF26),
                            value: analyticsData.txnCashbacks,
                            title: 'Cashbacks\n ₹${analyticsData.txnCashbacks}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            titlePositionPercentageOffset: 0.99,
                            radius: 20),
                        PieChartSectionData(
                            color: const Color(0xFFEE2727),
                            value: analyticsData.txnTransactions,
                            title: 'Txns\n ₹${analyticsData.txnTransactions}',
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
