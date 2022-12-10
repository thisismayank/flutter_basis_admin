import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';

class TransactionssAnalytics extends StatelessWidget {
  const TransactionssAnalytics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return SizedBox(
          height: 300,
          width: 100,
          child: Stack(children: [
            PieChart(PieChartData(
                centerSpaceRadius: 70,
                startDegreeOffset: -50,
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
                          backgroundColor: Color.fromARGB(164, 255, 255, 255)),
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
          );
    });
  }
}
