import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/rewards_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/transactions_analytics_ui.dart';

class RightTopPanelPage extends StatefulWidget {
  const RightTopPanelPage({Key? key}) : super(key: key);

  @override
  State<RightTopPanelPage> createState() => _RightTopPanelPageState();
}

class _RightTopPanelPageState extends State<RightTopPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RewardsAnalytics());
  }
}
