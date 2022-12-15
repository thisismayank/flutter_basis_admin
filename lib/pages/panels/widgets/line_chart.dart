// ignore_for_file: unnecessary_const

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:provider/provider.dart';

class LineChartSample2 extends StatelessWidget {
  LineChartSample2(
      {Key? key,
      required this.userDataCounts,
      required this.xAxisTitle,
      required this.numberofMonths,
      required this.maxYCoordinate})
      : super(key: key);

  final double numberofMonths;
  final double maxYCoordinate;
  final List userDataCounts;
  final List xAxisTitle;

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Flexible(
              flex: 1,
              child: const Text(
                'PPC Activation Monthly Stats',
                style: TextStyle(
                    color: Color(0xff5ecd98),
                    fontSize: 16,
                    backgroundColor: const Color.fromARGB(11, 255, 255, 255)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 5,
                child: LineChart(
                  mainData(),
                )),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    List titles = <String>[
      "",
      xAxisTitle[0],
      xAxisTitle[1],
      xAxisTitle[2],
      xAxisTitle[3],
    ];

    if (value < numberofMonths + 1) {
      final Widget text = Text(
        titles[value.toInt()],
        style: const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16, //margin top
        child: text,
      );
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16, //margin top
        child: Container());
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: numberofMonths + 2,
      minY: 0,
      maxY: maxYCoordinate,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 0),
            FlSpot(1, userDataCounts[0].toDouble()),
            FlSpot(2, userDataCounts[1].toDouble()),
            FlSpot(3, userDataCounts[2].toDouble()),
            FlSpot(4, userDataCounts[3].toDouble())
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
