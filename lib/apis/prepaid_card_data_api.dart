import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
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
    print('res $responseData');
    Provider.of<GlobalAnalytics>(context, listen: false).setGlobalDataForAdmin(
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

    //   if (ResponsiveLayout.isPhone(context)) {
    //     Navigator.pushNamed(context, "/global",
    //         arguments: {"userData": authToken, "authToken": authToken});
    //     return responseData;
    //   } else {
    return responseData;
    //   }
  }

  void getUserDataForAdmin(userId, userInformation, authToken, context) async {
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
}
