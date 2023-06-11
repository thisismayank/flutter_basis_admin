import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';

class MintyData {
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
    Navigator.pushNamed(context, "/minty",
        arguments: {"context": context, "authToken": authToken});
    // return responseData;
  }
}
