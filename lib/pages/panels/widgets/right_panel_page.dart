import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';

class RightPanelPage extends StatefulWidget {
  const RightPanelPage({Key? key}) : super(key: key);

  @override
  State<RightPanelPage> createState() => _RightPanelPageState();
}

class _RightPanelPageState extends State<RightPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [TransactionssAnalytics(), RewardsAnalytics()],
        )),
      ),
    );
  }
}
