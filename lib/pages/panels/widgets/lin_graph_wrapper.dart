import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/line_chart.dart';
import 'package:provider/provider.dart';

class LineGraphWrapper extends StatelessWidget {
  const LineGraphWrapper(
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
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, barGraphData, child) {
      return LineChartSample2(
          userDataCounts: userDataCounts,
          maxYCoordinate: maxYCoordinate,
          xAxisTitle: xAxisTitle,
          numberofMonths: numberofMonths);
    });
  }
}