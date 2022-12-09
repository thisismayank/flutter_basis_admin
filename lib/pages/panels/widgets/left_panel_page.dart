import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/dashboard.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/email.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/otp.dart';
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
      body: Column(children: [
        if (ResponsiveLayout.isComputer(context))
          Expanded(
              child: Container(
            color: Color(0xff26c182),
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.purple[500],
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(50))),
            ),
          )),
        // Expanded(
        //     child:
        SingleChildScrollView(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Card(
                      color: Colors.white38,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Home(),
                    )),
              )
            ],
          ),
        )
      ]),
    );
  }
}
