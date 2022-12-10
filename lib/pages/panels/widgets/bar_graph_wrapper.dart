import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:provider/provider.dart';

class BarGraphWrapper extends StatefulWidget {
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
  State<BarGraphWrapper> createState() => _BarGraphWrapperState();
}

class _BarGraphWrapperState extends State<BarGraphWrapper> {
  @override
  void initState() {
    // TODO: implement initState
    // getBarChartData();
    super.initState();
  }

  void getBarChartData() async {
    print("COME");
    PrepaidCardData prepaidCardData = PrepaidCardData();
    prepaidCardData.barGraphData(widget.authToken, widget.rootContext);
  }

  Future<Widget> getActivatedUsersData() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.barGraphData(widget.authToken, widget.rootContext);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalAnalytics>(builder: (context, barGraphData, child) {
      print('wrapper $barGraphData');
      return FutureBuilder<Widget?>(
          future: getActivatedUsersData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: BarChartSample2(
                      walletTransactions: barGraphData.walletTransactions,
                      merchantTransactions: barGraphData.merchantTransactions));
            } else {
              return const CircularProgressIndicator(
                color: Colors.green,
              );
            }
          });
    });
  }
}
