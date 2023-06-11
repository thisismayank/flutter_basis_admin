import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineDoubleChartSample2 extends StatelessWidget {
  final Color walletDataColor = const Color(0xff5ecd98);
  final Color merchantDataColor = const Color(0xff91a5ec);
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
      xAxisTitle[4],
      xAxisTitle[5],
      xAxisTitle[6],
      xAxisTitle[7],
      xAxisTitle[8],
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
        color: walletDataColor,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        spots: [
          const FlSpot(0, 0),
          FlSpot(1, monthlyWalletLoadData[0].toDouble()),
          FlSpot(2, monthlyWalletLoadData[1].toDouble()),
          FlSpot(3, monthlyWalletLoadData[2].toDouble()),
          FlSpot(4, monthlyWalletLoadData[3].toDouble()),
          FlSpot(5, monthlyWalletLoadData[4].toDouble()),
          FlSpot(6, monthlyWalletLoadData[5].toDouble()),
          FlSpot(7, monthlyWalletLoadData[6].toDouble()),
          FlSpot(8, monthlyWalletLoadData[6].toDouble()),
          FlSpot(9, monthlyWalletLoadData[7].toDouble()),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: merchantDataColor,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        spots: [
          const FlSpot(0, 0),
          FlSpot(1, monthlyMerchantTransactionsData[0].toDouble()),
          FlSpot(2, monthlyMerchantTransactionsData[1].toDouble()),
          FlSpot(3, monthlyMerchantTransactionsData[2].toDouble()),
          FlSpot(4, monthlyMerchantTransactionsData[3].toDouble()),
          FlSpot(5, monthlyMerchantTransactionsData[4].toDouble()),
          FlSpot(6, monthlyMerchantTransactionsData[5].toDouble()),
          FlSpot(7, monthlyMerchantTransactionsData[6].toDouble()),
          FlSpot(8, monthlyMerchantTransactionsData[7].toDouble()),
          FlSpot(9, monthlyMerchantTransactionsData[8].toDouble()),
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
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Count Of Users Who Transacted",
                        style: TextStyle(
                            color: Color.fromARGB(255, 70, 183, 132),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: merchantDataColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Merchant Txns',
                                style: TextStyle(
                                    color: merchantDataColor, fontSize: 14),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '$totalCountOfUsersWhoDidMerchantTransactions',
                                style: TextStyle(
                                    color: merchantDataColor, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: walletDataColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Wallet Txns',
                                style: TextStyle(
                                    color: walletDataColor, fontSize: 14),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '$totalCountOfUsersWhoLoadedWallets',
                                style: TextStyle(
                                    color: walletDataColor, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
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
