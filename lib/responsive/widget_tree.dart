import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/app_bar_widget.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/center_panel_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/drawer_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/left_panel_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/right_panel_page.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarWidget(),
        preferredSize: Size(double.infinity, 100),
      ),
      body: ResponsiveLayout(
          phone: CenterPanelPage(),
          computer: Row(
            children: const [
              Expanded(child: DrawerPage()),
              Expanded(child: LeftPanelPage()),
              Expanded(child: CenterPanelPage()),
              Expanded(child: RightPanelPage())
            ],
          )),
      drawer: DrawerPage(),
    );
  }
}
