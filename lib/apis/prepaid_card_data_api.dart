import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/pages/webview/widgets/webview.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class PrepaidCardData {
  Future<Map> getAllUsersWhoActivatedPowerCard(
      authToken, context, offset, limit) async {
    var uri = Uri.parse(
        "https://api.getbasis.co/v7/admins/all/prepaid/activated/users?offset=$offset&limit=$limit");
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
    Map responseData = jsonDecode(response.body);
    Provider.of<PrepaidDataStore>(context, listen: false)
        .allUsersWhoActivatedCardListMethod(responseData["results"]);

    return responseData;
  }

  Future<Map> getGlobalAnalyticsDataForAdmin(authToken, context) async {
    var uri =
        Uri.parse("https://api.getbasis.co/v6.4/admins/global/analytics/data");
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
    Map responseData = jsonDecode(response.body);

    Provider.of<GlobalAnalytics>(context, listen: false).setGlobalDataForAdmin(
      responseData["results"]["creditCardUserStatesAnalytics"]["activated"],
      responseData["results"]["creditCardUserStatesAnalytics"]["rejected"],
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

    //   if (ResponsiveLayout.isPhone(context)) {
    //     Navigator.pushNamed(context, "/global",
    //         arguments: {"userData": authToken, "authToken": authToken});
    //     return responseData;
    //   } else {
    return responseData;
    //   }
  }

  void getUserDataForAdmin(
      userId, rootUserData, userInformation, authToken, context) async {
    var uri = Uri.parse(
        "https://api.getbasis.co/v6.4/admins/check/user/data?field=" +
            userInformation.toString());
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer ${authToken}'});

    Map responseData = jsonDecode(response.body);

    Provider.of<UserData>(context, listen: false).setUserDataForAdmin(
        responseData["results"]["userId"],
        responseData["results"]["name"],
        responseData["results"]["email"],
        responseData["results"]["phoneNumber"],
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

    String route =
        ResponsiveLayout.isComputer(context) ? "/dashboard" : "/search";

    Navigator.pushNamed(context, route, arguments: {
      "authToken": authToken,
      "userId": userId,
      "context": context,
      "screen": 1,
      "userData": rootUserData,
      "selectedUserId": responseData["results"]["userId"]
    });
  }

  void getPrepaidStoreData(userId, rootUserData, authToken, context) async {
    var uri =
        Uri.parse("https://api.getbasis.co/v6.4/admins/prepaid/user/data");
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
    Map responseData = jsonDecode(response.body);

    Provider.of<PrepaidDataStore>(context, listen: false)
        .setDataToPrepaidStore(responseData["results"]);

    String route =
        ResponsiveLayout.isComputer(context) ? "/dashboard" : "/prepaid";

    Navigator.pushNamed(context, route, arguments: {
      "authToken": authToken,
      "userId": userId,
      "context": context,
      "screen": 2,
      "userData": rootUserData
    });
  }

  void getPosts(userId, authToken, context) async {
    var uri = Uri.parse("https://api.getbasis.co/v7/posts");

    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

    Map responseData = jsonDecode(response.body);

    Provider.of<Post>(context, listen: false).setAPost(
        responseData["results"][0]["_id"],
        responseData["results"][0]["body"],
        responseData["results"][0]["createdAt"],
        responseData["results"][0]["postOwnerUserId"],
        responseData["results"][0]["userName"]);

    Navigator.pushNamed(context, "/post");
  }

  void getMasterClassRegistrantsCSV(userId, authToken) async {
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

  void accessPWA(authToken, context) async {
    var uri =
        Uri.parse("https://api.getbasis.co/v6.4/prepaidcards?isfromweb=true");
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

    Map responseData = jsonDecode(response.body);

    String pwaUrl = responseData["results"][0]["url"];

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewPage(pwaUrl, "Basis Power Card")));
  }

  void accessBasisWebApp(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const WebViewPage("https://app.getbasis.co", "Basis")));
  }

  Future<Map> barGraphData(authToken, context) async {
    try {
      var uri = Uri.parse(
          "https://api.getbasis.co/v7/admins/transactions/merchant/wallet/weekly");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);

      Provider.of<GlobalAnalytics>(context, listen: false).setBarChartData(
        responseData["results"]["walletTransactions"],
        responseData["results"]["merchantTransactions"],
        responseData["results"]["xAxisTitles"],
        responseData["results"]["maxYCoordinate"],
      );
      return responseData;
    } catch (error) {
      throw error;
    }
  }

  Future<Map> getGeoData(authToken, context) async {
    try {
      var uri = Uri.parse("https://api.getbasis.co/v7/admins/geo/count/users");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);

      Provider.of<GlobalAnalytics>(context, listen: false).setGeoData(
        responseData["results"]["stateToPpcActivationCount"],
        responseData["results"]["refreshTime"],
        responseData["results"]["cityToTransactionAmount"],
      );
      return responseData;
    } catch (error) {
      throw error;
    }
  }

  Future<Map> getLineDoubleChartData(authToken, context) async {
    try {
      var uri = Uri.parse(
          "https://api.getbasis.co/v7/admins/prepaid/transactions/grouped/monthly");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);

      Provider.of<GlobalAnalytics>(context, listen: false)
          .setDoubleLineChartData(
        responseData["results"]["monthlyWalletLoadData"],
        responseData["results"]["totalCountOfUsersWhoLoadedWallets"],
        responseData["results"]["monthlyMerchantTransactionsData"],
        responseData["results"]["totalCountOfUsersWhoDidMerchantTransactions"],
        responseData["results"]["xAxisTitles"],
        responseData["results"]["maxYCoordinate"],
      );
      return responseData;
    } catch (error) {
      print("ERROR barGraphData $error");
      throw error;
    }
  }

  Future<Map> getLineGraphData(authToken, context, analyticsData) async {
    try {
      if (analyticsData == 0) {
        var uri = Uri.parse(
            "https://api.getbasis.co/v7/admins/prepaid/activated/users/monthly");
        var response = await http
            .get(uri, headers: {"Authorization": 'Bearer $authToken'});

        Map responseData = jsonDecode(response.body);

        Provider.of<GlobalAnalytics>(context, listen: false).setLineChartData(
          responseData["results"]["prepaidCardListOfUserCounts"],
          responseData["results"]["numberOfMonths"],
          responseData["results"]["xAxisTitles"],
          responseData["results"]["maxYCoordinate"],
        );

        return responseData;
      } else {
        return {};
      }
    } catch (error) {
      print("ERROR getLineGraphData $error");
      throw error;
    }
  }

  void getAllChats(authToken, context, offset, limit) async {
    var uri = Uri.parse(
        "https://api.getbasis.co/v7.2/admins/openai/chats?offset=$offset&limit=$limit");
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
    Map responseData = jsonDecode(response.body);
    // print('HELLO $responseData');
    Provider.of<MintyDataStore>(context, listen: false).setDataToMintyStore(
        responseData["results"]["countOfChats"],
        responseData["results"]["finalChatList"],
        responseData["results"]["uniqueUserIds"]);
    // print("LAST");
    // return responseData;
  }
}
