import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget myMobileBody;
  final Widget myDesktopBody;

  const ResponsiveLayout(
      {Key? key, required this.myDesktopBody, required this.myMobileBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return myDesktopBody;
      } else {
        return myMobileBody;
      }
    });
  }
}
