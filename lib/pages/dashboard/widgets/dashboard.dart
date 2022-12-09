import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/logged_in_user_ui.dart';

import 'package:flutter_application_6_provider/pages/webview/widgets/webview.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {Key? key,
      required this.userId,
      required this.authToken,
      required this.rootContext})
      : super(key: key);
  final String userId;
  final String authToken;
  final BuildContext rootContext;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSomeData();
  }

  void getSomeData() async {
    print("LLLLLAAAAAAAA");
    PrepaidCardData prepaidCardData = PrepaidCardData();
    await prepaidCardData.getGlobalAnalyticsDataForAdmin(
        widget.authToken, widget.rootContext);
  }

  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)?.settings.arguments as Map;
    // String token = data["userData"]["token"] ?? "";

    if (widget.authToken.isEmpty) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/");
    }
    // String userId = data["userData"]["_id"];

    // String authToken = '$userId,$token';
    var searchController = TextEditingController();
    void getAnalyticsDataForAdmin() async {
      // print('aut ${widget.authToken}');
      // print("here");
      // var uri = Uri.parse(
      //     "https://api.getbasis.co/v6.4/admins/global/analytics/data");
      // print('ur $uri');
      // var response = await http
      //     .get(uri, headers: {"Authorization": 'Bearer ${widget.authToken}'});
      // Map responseData = jsonDecode(response.body);
      // print('res $responseData');

      //   Provider.of<GlobalAnalytics>(context, listen: false)
      //       .setGlobalDataForAdmin(
      //     responseData["results"]["creditCardUserStatesAnalytics"]["activated"],
      //     responseData["results"]["creditCardUserStatesAnalytics"]
      //         ["yesterdayUsers"],
      //     responseData["results"]["creditCardUserStatesAnalytics"]["inProgress"],
      //     responseData["results"]["creditCardUserStatesAnalytics"]["manualCheck"],
      //     responseData["results"]["creditCardUserStatesAnalytics"]
      //         ["physicallyActivatedCards"],
      //     responseData["results"]["rewardStatusAnalytics"]["redeemed"],
      //     responseData["results"]["rewardStatusAnalytics"]["locked"],
      //     responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
      //         ["walletTransactions"],
      //     responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
      //         ["transactions"],
      //     responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
      //         ["cashbacks"],
      //     responseData["results"]["creditCardUserStatesAnalytics"]["total"],
      //     responseData["results"]["rewardStatusAnalytics"]["total"],
      //     responseData["results"]["balanceTransactionsAndCashbacksAnalytics"]
      //         ["total"],
      //     responseData["results"]["inProgressExactStepAnalytics"]["basicDetails"],
      //     responseData["results"]["inProgressExactStepAnalytics"]["pan"],
      //     responseData["results"]["inProgressExactStepAnalytics"]["address"],
      //     responseData["results"]["inProgressExactStepAnalytics"]["otp"],
      //   );
      //   print("ROUTING");
      //   Navigator.pushNamed(context, "/global", arguments: {
      //     "userData": widget.userId,
      //     "authToken": widget.authToken
      //   });
    }

    // void getUserDataForAdmin() async {
    //   var uri = Uri.parse(
    //       "https://api.getbasis.co/v6.4/admins/check/user/data?field=" +
    //           searchController.text.toString());
    //   var response = await http
    //       .get(uri, headers: {"Authorization": 'Bearer ${widget.authToken}'});

    //   Map responseData = jsonDecode(response.body);

    //   Provider.of<UserData>(context, listen: false).setUserDataForAdmin(
    //       responseData["results"]["userId"],
    //       responseData["results"]["name"],
    //       responseData["results"]["email"],
    //       responseData["results"]["customerId"],
    //       responseData["results"]["accountId"],
    //       responseData["results"]["balance"],
    //       responseData["results"]["cardActivatedDate"].toString(),
    //       responseData["results"]["sourceOfSignUp"],
    //       responseData["results"]["basisUserSince"].toString(),
    //       responseData["results"]["totalMerchantTransactionsValue"],
    //       responseData["results"]["totalWalletTransactionsValue"],
    //       responseData["results"]["totalCashbackValue"],
    //       responseData["results"]["cardId"],
    //       responseData["results"]["creditCardState"],
    //       responseData["results"]["reason"],
    //       responseData["results"]["nameCheck"]);

    //   Navigator.pushNamed(context, "/search", arguments: {
    //     "userId": widget.userId,
    //     "authToken": widget.authToken,
    //     "fetchedUserId": responseData["results"]["userId"]
    //   });
    // }

    void getPosts() async {
      var uri = Uri.parse("https://api.getbasis.co/v7/posts");

      var response = await http
          .get(uri, headers: {"Authorization": 'Bearer ${widget.authToken}'});

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
      var uri = Uri.parse(
          'https://api.getbasis.co/v6.4/users/${widget.userId}/mail/masterclass/registrants');

      var response = await http
          .get(uri, headers: {"Authorization": 'Bearer ${widget.authToken}'});

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
      var uri =
          Uri.parse("https://api.getbasis.co/v6.4/prepaidcards?isfromweb=true");
      var response = await http
          .get(uri, headers: {"Authorization": 'Bearer ${widget.authToken}'});

      Map responseData = jsonDecode(response.body);

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
      return LoggedInUserData(
        userId: widget.userId,
        user: user,
        authToken: widget.authToken,
        rootContext: widget.rootContext,
        backgroundColor: Colors.black87,
      );
    });
  }
}
