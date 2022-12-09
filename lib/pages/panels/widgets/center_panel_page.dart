import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CenterPanelPage extends StatefulWidget {
  const CenterPanelPage({Key? key}) : super(key: key);

  @override
  State<CenterPanelPage> createState() => _CenterPanelPageState();
}

class _CenterPanelPageState extends State<CenterPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 183, 169, 169),
      ),
    );
  }
}
