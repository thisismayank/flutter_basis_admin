import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
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
}
