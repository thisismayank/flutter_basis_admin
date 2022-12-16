import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineDoubleChartSample2 extends StatelessWidget {
  const LineDoubleChartSample2(
      {Key? key,
      required this.monthlyWalletLoadData,
      required this.totalCountOfUsersWhoLoadedWallets,
      required this.monthlyMerchantTransactionsData,
      required this.totalCountOfUsersWhoDidMerchantTransactions,
      required this.xAxisTitle,
      required this.maxYCoordinate})
      : super(key: key);

  final List monthlyWalletLoadData;
  final double totalCountOfUsersWhoLoadedWallets;
  final List monthlyMerchantTransactionsData;
  final double totalCountOfUsersWhoDidMerchantTransactions;
  final double maxYCoordinate;
  final List xAxisTitle;
  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // leftTitles: AxisTitles(
        //   sideTitles: leftTitles(),
        // ),
      );

  List<LineChartBarData> get lineBarsData1 =>
      [lineChartBarData1_1, lineChartBarData1_2];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    List titles = <String>[
      "",
      xAxisTitle[0],
      xAxisTitle[1],
      xAxisTitle[2],
      xAxisTitle[3],
    ];

    if (value < xAxisTitle.length + 1) {
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

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      horizontalInterval: 100,
      verticalInterval: 1);

  FlBorderData get borderData => FlBorderData(
        show: false,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff4af699),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        spots: [
          const FlSpot(0, 0),
          FlSpot(1, monthlyWalletLoadData[0].toDouble()),
          FlSpot(2, monthlyWalletLoadData[1].toDouble()),
          FlSpot(3, monthlyWalletLoadData[2].toDouble()),
          FlSpot(4, monthlyWalletLoadData[3].toDouble())
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0xffaa4cfc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        spots: [
          const FlSpot(0, 0),
          FlSpot(1, monthlyMerchantTransactionsData[0].toDouble()),
          FlSpot(2, monthlyMerchantTransactionsData[1].toDouble()),
          FlSpot(3, monthlyMerchantTransactionsData[2].toDouble()),
          FlSpot(4, monthlyMerchantTransactionsData[3].toDouble())
        ],
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Shop ',
                      style: TextStyle(
                        color: Color(0xff827daa),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Unfold  2018',
                      style: TextStyle(
                        color: Color(0xff827daa),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: LineChart(
                      LineChartData(
                        lineTouchData: lineTouchData1,
                        gridData: gridData,
                        titlesData: titlesData1,
                        borderData: borderData,
                        lineBarsData: lineBarsData1,
                        minX: 0,
                        maxX: xAxisTitle.length + 1,
                        maxY: maxYCoordinate - 1,
                        minY: 0,
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
