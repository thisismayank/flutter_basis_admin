import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_graph_wrapper.dart';

import '../../../apis/prepaid_card_data_api.dart';
import '../../global_analytics/widgets/transactions_analytics_ui.dart';

class RightPanelPageWithBarPieChartOnDesktop extends StatelessWidget {
  const RightPanelPageWithBarPieChartOnDesktop(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext,
      required this.userInformation,
      required this.onClicked})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;
  final int userInformation;
  final VoidCallback onClicked;
  Future<Widget> getBarGraphData() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.barGraphData(authToken, rootContext);

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Row(
            children: [
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: TransactionssAnalytics(
                    authToken: authToken,
                    rootContext: rootContext,
                    userData: {},
                  )),
              Flexible(flex: 1, fit: FlexFit.tight, child: RewardsAnalytics()),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Flexible(
            flex: 3,
            child:
                // Container()
                FutureBuilder<Widget?>(
                    future: getBarGraphData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return BarGraphWrapper(
                          rootContext: rootContext,
                          userId: userData["_id"],
                          authToken: authToken,
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.green,
                        );
                      }
                    })),
        Flexible(
            flex: 3,
            child: IconButton(
                onPressed: onClicked,
                icon: Icon(
                  Icons.class_sharp,
                  size: 24,
                )))
      ],
    );
  }
}
