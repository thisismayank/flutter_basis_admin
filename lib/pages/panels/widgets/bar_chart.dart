import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:provider/provider.dart';

class BarChartSample2 extends StatefulWidget {
  const BarChartSample2(
      {Key? key,
      required this.walletTransactions,
      required this.merchantTransactions,
      required this.xAxisTitles,
      required this.maxYCoordinate})
      : super(key: key);
  final List merchantTransactions;
  final List walletTransactions;
  final List xAxisTitles;
  final double maxYCoordinate;
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff5ecd98);
  final Color rightBarColor = const Color(0xff91a5ec);
  final double width = 15;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(
        0, widget.walletTransactions[0], widget.merchantTransactions[0]);
    final barGroup2 = makeGroupData(
        1, widget.walletTransactions[1], widget.merchantTransactions[1]);
    final barGroup3 = makeGroupData(
        2, widget.walletTransactions[2], widget.merchantTransactions[2]);
    final barGroup4 = makeGroupData(
        3, widget.walletTransactions[3], widget.merchantTransactions[3]);
    final barGroup5 = makeGroupData(
        4, widget.walletTransactions[4], widget.merchantTransactions[4]);
    final barGroup6 = makeGroupData(
        5, widget.walletTransactions[5], widget.merchantTransactions[5]);
    final barGroup7 = makeGroupData(
        6, widget.walletTransactions[6], widget.merchantTransactions[6]);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(-4, 4),
                color: Color.fromARGB(0, 255, 255, 255)),
            BoxShadow(
                blurRadius: 6,
                offset: Offset(8, 8),
                color: Color.fromARGB(48, 0, 0, 0))
          ]),
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 16, 4, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        color: leftBarColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Merchant Txns',
                        style: TextStyle(color: leftBarColor, fontSize: 16),
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
                        color: rightBarColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Wallet Txns',
                        style: TextStyle(color: rightBarColor, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                    maxY: widget.maxYCoordinate,
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
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      // leftTitles: AxisTitles(
                      //   sideTitles: SideTitles(
                      //     showTitles: true,
                      //     reservedSize: 28,
                      //     interval: 1,
                      //     getTitlesWidget: leftTitles,
                      //   ),
                      // ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 5000,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget leftTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff7589a2),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 14,
  //   );
  //   String text;
  //   if (value % 10000 == 0) {
  //     text = '$value';
  //   } else {
  //     return Container();
  //   }
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 0,
  //     child: Text(text, style: style),
  //   );
  // }

  Widget bottomTitles(double value, TitleMeta meta) {
    List titles = <String>[
      widget.xAxisTitles[1],
      widget.xAxisTitles[2],
      widget.xAxisTitles[3],
      widget.xAxisTitles[4],
      widget.xAxisTitles[5],
      widget.xAxisTitles[6],
      widget.xAxisTitles[7],
    ];

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

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      // showingTooltipIndicators: [0, 1],
      barRods: [
        BarChartRodData(
            toY: y1,
            color: leftBarColor,
            width: x < 5 ? 7 : width,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            )),
        if (y2 != 0)
          BarChartRodData(
              toY: y2,
              color: rightBarColor,
              width: x < 5 ? 7 : width,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              )),
        // if (y2 > 5)
        //   BarChartRodData(
        //     toY: y1,
        //     color: Colors.red,
        //     width: width,
        //   ),
      ],
    );
  }
}
