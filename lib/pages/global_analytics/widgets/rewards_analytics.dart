import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';

class RewardsAnalytics extends StatelessWidget {
  const RewardsAnalytics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, analyticsData, child) {
      return SizedBox(
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
                        title:
                            'Locked \n ${analyticsData.rewardLocked.toInt()}',
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
                            'Redeemed\n ${analyticsData.rewardRedeemed.toInt()}',
                        titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                                Color.fromARGB(124, 255, 255, 255)),
                        titlePositionPercentageOffset: 0.99,
                        radius: 30),
                  ]),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear,
            ),
            Positioned.fill(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Rewards\n${analyticsData.totalRewards.toInt()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ))
          ])
          // ],
          );
    });
  }
}
