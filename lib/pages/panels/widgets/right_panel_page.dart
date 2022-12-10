import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_chart.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/bar_graph_wrapper.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';

class RightPanelPage extends StatefulWidget {
  const RightPanelPage(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;

  @override
  State<RightPanelPage> createState() => _RightPanelPageState();
}

class _RightPanelPageState extends State<RightPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(child: TransactionssAnalytics()),
                Expanded(child: RewardsAnalytics()),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Flexible(flex: 3, child: Container()
              // BarGraphWrapper(
              //   rootContext: widget.rootContext,
              //   userId: widget.userData["_id"],
              //   authToken: widget.authToken,
              // ),
              )
        ],
      ),
    );
  }
}
