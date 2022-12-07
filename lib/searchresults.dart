import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/userdata.dart';
import 'package:flutter_application_6_provider/fetcheduserdetails.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Widget cardTemplate(user, icon, showCopyIcon) {
    return SearchResultsDataCard(
      user: user,
      icon: icon,
      showCopy: showCopyIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final passedData = ModalRoute.of(context)?.settings.arguments as Map;
    String authToken = passedData["authToken"];
    String userId = passedData["userId"];
    String fetchedUserId = passedData["fetchedUserId"];

    var nameController = TextEditingController();

    void updateName() async {
      var uri = Uri.parse(
          "https://api.getbasis.co/v7/admins/manual/check/name/prepaid/card/logic");
      var response = await http.put(
        uri,
        body: {
          "userIds": fetchedUserId.toString(),
          "name": nameController.text.toString()
        },
        headers: {"Authorization": 'Bearer $authToken'},
      );

      Map responseData = jsonDecode(response.body);

      Fluttertoast.showToast(
          msg:
              '${responseData["message"]} - Updated Name: ${responseData["results"]["updatedName"]}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5);
    }

    void updateDob() async {
      var uri = Uri.parse('https://api.getbasis.co/v7/admins/update/state');
      var response =
          await http.post(uri, body: {"email": nameController.text.toString()});
    }

    return Consumer<UserData>(builder: (context, user, child) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              user.name.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xff36c182),
          ),
          body: Card(
              // physics: const BouncingScrollPhysics(),
              child: SingleChildScrollView(
            child: Column(
              children: [
                cardTemplate(user.id, Icons.perm_identity, true),
                cardTemplate(user.name, Icons.note, true),
                cardTemplate(user.email, Icons.email, true),
                user.accountId == ""
                    ? Container()
                    : cardTemplate(user.accountId, Icons.account_box, true),
                user.customerId == ""
                    ? Container()
                    : cardTemplate(user.customerId, Icons.woman, true),
                user.cardId == ""
                    ? Container()
                    : cardTemplate(user.cardId, Icons.credit_card, true),
                cardTemplate(
                    user.creditCardState, Icons.tab_unselected_rounded, false),
                user.cardId == ""
                    ? Container()
                    : cardTemplate(user.cardActivationDate,
                        Icons.calendar_month_outlined, false),
                cardTemplate(user.sourceOfSignUp, Icons.mobile_friendly, false),
                cardTemplate(user.basisUserSince, Icons.login, false),
                user.creditCardState == "MANUAL_CHECK_CREDIT"
                    ? Column(children: [
                        cardTemplate(user.reason, Icons.read_more, true),
                        user.nameCheck == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                      width: 400,
                                      child: TextField(
                                        controller: nameController,
                                        onSubmitted: (String value) {
                                          updateName();
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Enter Name',
                                            hintText: 'Enter The Correct Name'),
                                      )),
                                ],
                              )
                            : IconButton(
                                icon: Icon(Icons.thumb_up_alt_sharp),
                                color: Colors.green,
                                onPressed: () {},
                              )
                      ])
                    : SizedBox(),
                user.cardId == ""
                    ? Container()
                    : const Divider(
                        height: 60,
                        thickness: 10,
                        indent: 20,
                        endIndent: 20,
                      ),
                user.cardId == ""
                    ? Container()
                    : const Text(
                        "Transactions Breakdown",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                const SizedBox(
                  height: 20,
                ),
                user.cardId == ""
                    ? Container()
                    : SizedBox(
                        height: 200,
                        child: Stack(children: [
                          PieChart(PieChartData(
                              centerSpaceRadius: 70,
                              startDegreeOffset: -45,
                              sections: [
                                PieChartSectionData(
                                    color: const Color(0xFF26E5FF),
                                    value: user.totalMerchantTransactionsValue,
                                    title:
                                        'Merchant Txns\n ₹${user.totalMerchantTransactionsValue}',
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    titlePositionPercentageOffset: 0.99,
                                    radius: 40),
                                PieChartSectionData(
                                    color: const Color(0xFFFFCF26),
                                    value: user.totalWalletTransactionsValue,
                                    title:
                                        'Wallet Txns\n ₹${user.totalWalletTransactionsValue}',
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    titlePositionPercentageOffset: 0.99,
                                    radius: 30),
                                PieChartSectionData(
                                    color: const Color(0xFFEE2727),
                                    value: user.totalCashbackValue,
                                    title:
                                        'Cashbacks Earned\n ₹${user.totalCashbackValue}',
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    titlePositionPercentageOffset: 0.99,
                                    radius: 60),
                              ])),
                          Positioned.fill(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Balance",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                '₹ ${user.balance.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                        ]),
                      ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
