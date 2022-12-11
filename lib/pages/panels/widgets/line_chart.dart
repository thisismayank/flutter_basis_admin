// ignore_for_file: unnecessary_const

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2(
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

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 600,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: const [
        //   BoxShadow(
        //       blurRadius: 4,
        //       offset: Offset(-4, 4),
        //       color: Color.fromARGB(0, 255, 255, 255)),
        //   BoxShadow(
        //       blurRadius: 6,
        //       offset: Offset(8, 8),
        //       color: Color.fromARGB(48, 0, 0, 0))
        // ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            SizedBox(
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
      widget.xAxisTitle[0],
      widget.xAxisTitle[1],
      widget.xAxisTitle[2],
      widget.xAxisTitle[3],
    ];

    if (value < widget.numberofMonths + 1) {
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
      maxX: widget.numberofMonths + 2,
      minY: 0,
      maxY: widget.maxYCoordinate,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 0),
            FlSpot(1, widget.userDataCounts[0]),
            FlSpot(2, widget.userDataCounts[1]),
            FlSpot(3, widget.userDataCounts[2]),
            FlSpot(4, widget.userDataCounts[3])
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
