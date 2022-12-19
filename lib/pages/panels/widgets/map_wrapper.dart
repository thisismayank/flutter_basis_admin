import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/app_bar_widget.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/drawer_page.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/right_panel_back_page.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

class MapWrapper extends StatelessWidget {
  const MapWrapper(
      {Key? key,
      required this.authToken,
      required this.rootContext,
      required this.userData})
      : super(key: key);
  final String authToken;
  final Map userData;
  final BuildContext rootContext;
  Future<Widget> getGeoData() async {
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.getGeoData(authToken, rootContext);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // print("userDataHere $userData");
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarWidget(
          userData: userData["userData"],
          rootContext: context,
          authToken: authToken,
          userId: userData["userData"]["_id"],
        ),
        preferredSize: ResponsiveLayout.isComputer(context)
            ? const Size(0, 100)
            : const Size(0, 70),
      ),
      // body: Container(),
      body: ResponsiveLayout(
        phone: Container(),
        computer: Row(children: [
          DrawerPage(
            userData: userData["userData"],
            rootContext: context,
            authToken: authToken,
          ),
          Expanded(
            child: FutureBuilder(
                future: getGeoData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Consumer<GlobalAnalytics>(
                        builder: ((context, mapData, child) {
                      return Padding(
                        padding: const EdgeInsets.all(.0),
                        child: RightPanelBackPage(
                            geoData: mapData.geoData,
                            refreshTime: mapData.refreshTime,
                            cityToTransactionData:
                                mapData.cityToTransactionAmountData),
                      );
                    }));
                  } else {
                    return Container();
                  }
                }),
          )
        ]),
      ),
    );
  }
}
