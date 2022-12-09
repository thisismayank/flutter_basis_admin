import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';

class LeftPanelPage extends StatefulWidget {
  const LeftPanelPage({Key? key}) : super(key: key);

  @override
  State<LeftPanelPage> createState() => _LeftPanelPageState();
}

class _LeftPanelPageState extends State<LeftPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(children: [
      if (ResponsiveLayout.isComputer(context))
        Container(
          color: Color(0xff26c182),
          width: 500,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.purple[500],
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(50))),
          ),
        )
    ]));
  }
}
