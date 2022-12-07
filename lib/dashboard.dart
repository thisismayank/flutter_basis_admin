import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/globalanalytics.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/user.dart';
import 'package:flutter_application_6_provider/userdata.dart';

import 'package:flutter_application_6_provider/webview.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("DASHBOARD");
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    print(data);

    String token = data["userData"]["token"] ?? "";

    if (token.isEmpty) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/");
    }
    String userId = data["userData"]["_id"];

    String authToken = '$userId,$token';
    var searchController = TextEditingController();

    void getAnalyticsDataForAdmin() async {
      var uri = Uri.parse(
          "https://api.getbasis.co/v6.4/admins/global/analytics/data");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
      Map responseData = jsonDecode(response.body);

      Provider.of<GlobalAnalytics>(context, listen: false)
          .setGlobalDataForAdmin(
        responseData["results"]["creditCardUserStatesAnalytics"]["activated"],
        responseData["results"]["creditCardUserStatesAnalytics"]
            ["yesterdayUsers"],
        responseData["results"]["creditCardUserStatesAnalytics"]["inProgress"],
        responseData["results"]["creditCardUserStatesAnalytics"]["manualCheck"],
        responseData["results"]["creditCardUserStatesAnalytics"]
            ["physicallyActivatedCards"],
        responseData["results"]["rewardStatusAnalytics"]["redeemed"],
        responseData["results"]["rewardStatusAnalytics"]["locked"],
        responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
            ["walletTransactions"],
        responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
            ["transactions"],
        responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
            ["cashbacks"],
        responseData["results"]["creditCardUserStatesAnalytics"]["total"],
        responseData["results"]["rewardStatusAnalytics"]["total"],
        responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
            ["total"],
        responseData["results"]["inProgressExactStepAnalytics"]["basicDetails"],
        responseData["results"]["inProgressExactStepAnalytics"]["pan"],
        responseData["results"]["inProgressExactStepAnalytics"]["address"],
        responseData["results"]["inProgressExactStepAnalytics"]["otp"],
      );
      Navigator.pushNamed(context, "/global",
          arguments: {"userData": data, "authToken": authToken});
    }

    void getUserDataForAdmin() async {
      var uri = Uri.parse(
          "https://api.getbasis.co/v6.4/admins/check/user/data?field=" +
              searchController.text.toString());
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);
      print('Res $responseData');
      // print('Res ${responseData["results"]["customerId"]}');

      Provider.of<UserData>(context, listen: false).setUserDataForAdmin(
          responseData["results"]["userId"],
          responseData["results"]["name"],
          responseData["results"]["email"],
          responseData["results"]["customerId"],
          responseData["results"]["accountId"],
          responseData["results"]["balance"],
          responseData["results"]["cardActivatedDate"].toString(),
          responseData["results"]["sourceOfSignUp"],
          responseData["results"]["basisUserSince"].toString(),
          responseData["results"]["totalMerchantTransactionsValue"],
          responseData["results"]["totalWalletTransactionsValue"],
          responseData["results"]["totalCashbackValue"],
          responseData["results"]["cardId"],
          responseData["results"]["creditCardState"],
          responseData["results"]["reason"],
          responseData["results"]["nameCheck"]);

      Navigator.pushNamed(context, "/search", arguments: {
        "userId": userId,
        "authToken": authToken,
        "fetchedUserId": responseData["results"]["userId"]
      });
    }

    void getPosts() async {
      var uri = Uri.parse("https://api.getbasis.co/v7/posts");

      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
      // print(response.body);
      Map responseData = jsonDecode(response.body);

      Provider.of<Post>(context, listen: false).setAPost(
          responseData["results"][0]["_id"],
          responseData["results"][0]["body"],
          responseData["results"][0]["createdAt"],
          responseData["results"][0]["postOwnerUserId"],
          responseData["results"][0]["userName"]);

      Navigator.pushNamed(context, "/post");
    }

    void getMasterClassRegistrantsCSV() async {
      String token = data["userData"]["token"];
      String userId = data["userData"]["_id"];
      String authToken = '$userId,$token';

      var uri = Uri.parse(
          'https://api.getbasis.co/v6.4/users/$userId/mail/masterclass/registrants');

      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);
      // Fluttertoast.showToast(
      //     msg: "Registrants List emailed successfully",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 2,
      //     backgroundColor: const Color(0xff36c182),
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }

    void accessBasisWebApp() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WebViewPage("https://app.getbasis.co", "Basis")));
    }

    void accessPWA() async {
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString(authToken, authToken);

      String token = data["userData"]["token"];
      String userId = data["userData"]["_id"];
      String authToken = '$userId,$token';
      // print("authToken" + authToken);
      var uri =
          Uri.parse("https://api.getbasis.co/v6.4/prepaidcards?isfromweb=true");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);
      print(responseData);
      String pwaUrl = responseData["results"][0]["url"];

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(pwaUrl, "Basis Power Card")));
    }

    void logoutUser() async {
      try {
        final sharedPreferenceInstance = await SharedPreferences.getInstance();
        await sharedPreferenceInstance.remove("userId");
        await sharedPreferenceInstance.remove("token");
        await sharedPreferenceInstance.remove("avatar");
        await sharedPreferenceInstance.remove("creditCardState");
        await sharedPreferenceInstance.remove("firstName");
        await sharedPreferenceInstance.remove("lastName");
        await sharedPreferenceInstance.remove("email");

        Navigator.pushNamed(context, "/");
      } catch (error) {
        print('logout $error');
      }
    }

    return Consumer<User>(builder: (context, user, child) {
      return MaterialApp(
          home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Dashboard"),
          backgroundColor: const Color(0xff36c182),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("First name",
                            style: TextStyle(
                                color: Colors.grey, letterSpacing: 2.0)),
                        Text(
                          user.firstName + " " + user.lastName,
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.amberAccent,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.power_settings_new_outlined),
                      onPressed: (() => logoutUser()),
                      color: Colors.white,
                      hoverColor: Colors.red,
                      iconSize: 32,
                    )
                  ],
                ),
                const SizedBox(height: 32),
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
                const SizedBox(height: 32),
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
                const SizedBox(height: 32),
                ElevatedButton.icon(
                    onPressed: () {
                      getMasterClassRegistrantsCSV();
                    },
                    icon: const Icon(CupertinoIcons.rocket),
                    label: const Text("Get Masterclass registrants")),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                    onPressed: () {
                      getAnalyticsDataForAdmin();
                    },
                    icon: const Icon(CupertinoIcons.chart_pie_fill),
                    label: const Text("Get Global Analytics")),
                const SizedBox(
                  height: 32,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: TextField(
                    controller: searchController,
                    textAlign: TextAlign.center,
                    onSubmitted: (String value) {
                      getUserDataForAdmin();
                    },
                    decoration: InputDecoration(
                        hintText: "Search using userId, email, cstId, acId",
                        // icon: Icon(Icons.search),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getUserDataForAdmin();
                          },
                        ),
                        fillColor: Color.fromARGB(255, 255, 253, 253),
                        filled: true),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            accessPWA();
          },
          backgroundColor: const Color(0xff36c182),
          icon: const Icon(Icons.credit_card),
          label: const Text("Go to Power Card"),
        ),
      ));
    });
  }
}
