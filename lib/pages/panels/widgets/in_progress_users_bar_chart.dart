import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

class InProgressUsersBarChart extends StatefulWidget {
  const InProgressUsersBarChart(
      {Key? key,
      required this.basicDetails,
      required this.pan,
      required this.address,
      required this.otp})
      : super(key: key);
  final double basicDetails;
  final double pan;
  final double address;
  final double otp;
  @override
  State<StatefulWidget> createState() => InProgressUsersBarChartState();
}

class InProgressUsersBarChartState extends State<InProgressUsersBarChart> {
  final Color leftBarColor = const Color(0xff5ecd98);
  final Color rightBarColor = const Color(0xff91a5ec);
  final double width = 20;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  @override
  void initState() {
    super.initState();

    final barGroup1 = makeGroupData(0, widget.basicDetails);
    final barGroup2 = makeGroupData(1, widget.pan);
    final barGroup3 = makeGroupData(2, widget.address);
    final barGroup4 = makeGroupData(3, widget.otp);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      // padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'In Progress Users',
                    style: TextStyle(color: leftBarColor, fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                    maxY: widget.basicDetails + 50,
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
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize:
                              ResponsiveLayout.isComputer(context) ? 24 : 30,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(
                      // getDrawingHorizontalLine: (value) {
                      //   if (value == 0) {
                      //     return FlLine(
                      //       color: const Color(0xff363753),
                      //       strokeWidth: 3,
                      //     );
                      //   }
                      //   return FlLine(
                      //     color: const Color(0xff2a2747),
                      //     strokeWidth: 0.8,
                      //   );
                      // },
                      // show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 100,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;

    if (value == 0) {
      text = "0";
    } else if (value == 100) {
      text = '100';
    } else if (value == 200) {
      text = '200';
    } else {
      return Container();
    }
    return SideTitleWidget(
      angle: ResponsiveLayout.isComputer(context) ? 0 : 100,
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List titles = <String>["basic details", "pan", "address", "otp"];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    );

    return SideTitleWidget(
      // angle: 100,
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      // showingTooltipIndicators: [0, 1],
      barRods: [
        BarChartRodData(
            toY: y1,
            color: x % 2 == 0 ? leftBarColor : rightBarColor,
            width: width,
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
