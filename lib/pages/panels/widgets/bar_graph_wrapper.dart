import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:provider/provider.dart';

class BarGraphWrapper extends StatelessWidget {
  const BarGraphWrapper(
      {Key? key,
      required this.userId,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final String userId;
  final BuildContext rootContext;
  final String authToken;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, barGraphData, child) {
      return BarChartSample2(
          walletTransactions: barGraphData.walletTransactions,
          merchantTransactions: barGraphData.merchantTransactions,
          xAxisTitles: barGraphData.xAxisTitles,
          maxYCoordinate: barGraphData.maxYCoordinate);
    });
  }
}
