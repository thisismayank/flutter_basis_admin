import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/line_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/line_double_chart.dart';
import 'package:provider/provider.dart';

class LineDoubleChartWrapper extends StatelessWidget {
  const LineDoubleChartWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, barGraphData, child) {
      return LineDoubleChartSample2(
          monthlyWalletLoadData: barGraphData.monthlyWalletLoadData,
          totalCountOfUsersWhoLoadedWallets:
              barGraphData.totalCountOfUsersWhoLoadedWallets.toDouble(),
          monthlyMerchantTransactionsData:
              barGraphData.monthlyMerchantTransactionsData,
          totalCountOfUsersWhoDidMerchantTransactions: barGraphData
              .totalCountOfUsersWhoDidMerchantTransactions
              .toDouble(),
          xAxisTitle: barGraphData.xAxisTitlesLineD,
          maxYCoordinate: barGraphData.maxYCoordinateLineD.toDouble());
      // );
    });
  }
}
