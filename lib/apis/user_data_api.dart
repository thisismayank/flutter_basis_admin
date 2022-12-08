import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';

class UserPrepaidCardData {
  Future<Map> getUserPrepaidData(
      selectedUserId, userId, authToken, context) async {
    var uri = Uri.parse(
        "https://api.getbasis.co/v6.4/admins/check/user/data?field=" +
            selectedUserId.toString());
    var response =
        await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

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
    return responseData;
  }
}