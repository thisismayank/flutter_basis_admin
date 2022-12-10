import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/search_bar_for_user_data.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:flutter_application_6_provider/utils/widgets/lib/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedInUserData extends StatelessWidget {
  const LoggedInUserData(
      {Key? key,
      required this.userId,
      required this.user,
      required this.backgroundColor,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final String userId;
  final User user;
  final Color backgroundColor;
  final String authToken;
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    print("WIDGET");
    var searchController = TextEditingController();
    PrepaidCardData prepaidCardData = PrepaidCardData();

    void getPrepaidDataOfUser() async {
      // PrepaidCardData prepaidCardData = PrepaidCardData();
      prepaidCardData.getUserDataForAdmin(
          userId, searchController.text.toString(), authToken, rootContext);
    }

    void getBarChartData() async {
      PrepaidCardData prepaidCardData = PrepaidCardData();
      // prepaidCardData.barGraphData(authToken, rootContext);
    }

    UserUtilsLib userUtils = UserUtilsLib();
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
                radius: 40,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(
              height: 10,
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name",
                        style: TextStyle(
                            color: Color.fromARGB(255, 190, 190, 190),
                            letterSpacing: 2.0)),
                    Text(
                      user.firstName + " " + user.lastName,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.power_settings_new_outlined),
                  onPressed: (() => userUtils.logoutUser(rootContext)),
                  color: Colors.white,
                  hoverColor: Colors.red,
                  iconSize: 24,
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text("Email",
                style: TextStyle(color: Colors.grey, letterSpacing: 2.0)),
            Text(
              user.email,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.amberAccent,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Credit Card State",
                style: TextStyle(color: Colors.grey, letterSpacing: 2.0)),
            Text(
              user.creditCardState,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.amberAccent,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if ((!ResponsiveLayout.isComputer(context)))
              ElevatedButton.icon(
                  onPressed: () {
                    getBarChartData();
                  },
                  icon: const Icon(CupertinoIcons.rocket),
                  label: const Text("Get Masterclass registrants")),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(height: 8),
            if ((!ResponsiveLayout.isComputer(context)))
              ElevatedButton.icon(
                  onPressed: () {
                    print("INSIDE");
                    getBarChartData();

                    // getAnalyticsDataForAdmin();
                  },
                  icon: const Icon(CupertinoIcons.chart_pie_fill),
                  label: const Text("Get Global Analytics")),
            const SizedBox(
              height: 16,
            ),
            if ((!ResponsiveLayout.isComputer(context)))
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SearchBarForUserData(
                      userId: userId,
                      authToken: authToken,
                      rootContext: rootContext))
          ],
        ),
      ),
      floatingActionButton: !ResponsiveLayout.isComputer(context)
          ? FloatingActionButton.extended(
              onPressed: () {
                // accessPWA();
              },
              backgroundColor: const Color(0xff5ECD9B),
              icon: const Icon(Icons.credit_card),
              label: const Text("Go to Power Card"),
            )
          : Container(),
    );
  }
}
