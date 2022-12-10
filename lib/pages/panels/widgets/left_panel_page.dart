import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';

class LeftPanelPage extends StatefulWidget {
  const LeftPanelPage(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;

  @override
  State<LeftPanelPage> createState() => _LeftPanelPageState();
}

class _LeftPanelPageState extends State<LeftPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
