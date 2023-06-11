import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/quiz_data_button.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/rejected_user_count_picker.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/search_bar_for_user_data.dart';
import 'package:flutter_application_6_provider/pages/minty/chat_button.dart';
import 'package:flutter_application_6_provider/pages/minty/list_chats.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:flutter_application_6_provider/utils/widgets/lib/user.dart';
import 'package:lottie/lottie.dart';
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
    var searchController = TextEditingController();
    PrepaidCardData prepaidCardData = PrepaidCardData();

    // void getPrepaidDataOfUser() async {
    //   // PrepaidCardData prepaidCardData = PrepaidCardData();
    //   prepaidCardData.getUserDataForAdmin(
    //       userId, searchController.text.toString(), authToken, rootContext);
    // }

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
                        style:
                            TextStyle(color: Colors.grey, letterSpacing: 2.0)),
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
            // if ((ResponsiveLayout.isComputer(context)))
            const SizedBox(height: 8),

            RejectedUserCountPicker(
              authToken: authToken,
              rootContext: rootContext,
              userId: userId,
            ),
            ChatButtons(authToken: authToken, rootContext: rootContext),
            const SizedBox(height: 8),

            DailyQuizDataButton(
                userId: userId, authToken: authToken, rootContext: rootContext),

            Lottie.network(
                "https://res.cloudinary.com/basis-static/raw/upload/v1668490322/Power%20Card/newAnimation.json",
                repeat: ResponsiveLayout.isComputer(context) ? false : true),
          ],
        ),
      ),
      floatingActionButton: !ResponsiveLayout.isComputer(context)
          ? FloatingActionButton.extended(
              onPressed: () {
                // accessPWA();
              },
              backgroundColor: Colors.white,
              icon: const Icon(Icons.credit_card, color: Color(0xff36c182)),
              label: const Text(
                "Go to Power Card",
                style: TextStyle(color: Color(0xff36c182)),
              ),
            )
          : Container(),
    );
  }
}
