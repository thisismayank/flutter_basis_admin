import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/fetched_prepaid_user_data_card.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SearchResults extends StatefulWidget {
  const SearchResults(
      {Key? key,
      required this.userData,
      required this.authToken,
      required this.rootContext,
      required this.userInformation})
      : super(key: key);
  final Map userData;
  final BuildContext rootContext;
  final String authToken;
  final int userInformation;

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
    print("widget data  ${widget.userData}");
    print("widget data aut ${widget.authToken}");

    final passedData = ModalRoute.of(context)?.settings.arguments as Map;
    print("passed data search ${passedData["userId"]}");
    print("passed data selectedUserId ${passedData["selectedUserId"]}");

    String authToken = passedData["authToken"];
    String userId = passedData["userId"];
    String fetchedUserId = passedData["selectedUserId"];

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

    void takeToDashboard() {
      Navigator.pop(widget.rootContext);
    }

    return Consumer<UserData>(builder: (context, user, child) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          bottomOpacity: 0.3,
          // toolbarOpacity: 0.2,
          leading: IconButton(
              onPressed: () {
                takeToDashboard();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              )),
          centerTitle: true,
          title: Text(
            user.name.toUpperCase(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: Container(
            // physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 253, 253),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      offset: Offset(-4, 4),
                      color: Color.fromARGB(0, 255, 255, 255)),
                  BoxShadow(
                      blurRadius: 4,
                      offset: Offset(8, 8),
                      color: Color.fromARGB(48, 0, 0, 0))
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  cardTemplate(user.id, Icons.perm_identity, true),
                  cardTemplate(user.name, Icons.note, true),
                  cardTemplate(user.email, Icons.email, true),
                  user.customerId == ""
                      ? Container()
                      : cardTemplate(user.customerId, Icons.woman, true),
                  user.accountId == ""
                      ? Container()
                      : cardTemplate(user.accountId, Icons.account_box, true),
                  user.cardId == ""
                      ? Container()
                      : cardTemplate(user.cardId, Icons.credit_card, true),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: DropdownButton(
                        value: 1,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(user.creditCardState),
                          ),
                          DropdownMenuItem(
                              value: 2, child: Text(user.sourceOfSignUp)),
                          DropdownMenuItem(
                              value: 3,
                              child:
                                  Text('Signed up on ${user.basisUserSince}')),
                          user.cardId != ""
                              ? DropdownMenuItem(
                                  value: 4,
                                  child: Text(
                                      'Card Activated on ${user.cardActivationDate}'))
                              : const DropdownMenuItem(
                                  value: 4, child: Text("Card not active yet")),
                        ],
                        onChanged: (_) {}),
                  ),
                  // cardTemplate(user.creditCardState,
                  //     Icons.tab_unselected_rounded, false),
                  // user.cardId == ""
                  //     ? Container()
                  //     : cardTemplate(user.cardActivationDate,
                  //         Icons.calendar_month_outlined, false),
                  // cardTemplate(
                  //     user.sourceOfSignUp, Icons.mobile_friendly, false),
                  // cardTemplate(user.basisUserSince, Icons.login, false),
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
                                              hintText:
                                                  'Enter The Correct Name'),
                                        )),
                                  ],
                                )
                              : IconButton(
                                  icon: const Icon(Icons.thumb_up_alt_sharp),
                                  color: Colors.green,
                                  onPressed: () {},
                                )
                        ])
                      : const SizedBox(),
                  user.cardId == "" || user.totalWalletTransactionsValue == 0
                      ? Container()
                      : const SizedBox(
                          height: 20,
                        ),
                  user.cardId == "" || user.totalWalletTransactionsValue == 0
                      ? Container()
                      : Column(children: [
                          const Text(
                            "Transactions Breakdown",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          user.cardId == ""
                              ? Container()
                              : SizedBox(
                                  height: 400,
                                  child: Stack(children: [
                                    PieChart(PieChartData(
                                        centerSpaceRadius: 70,
                                        startDegreeOffset: -45,
                                        sections: [
                                          PieChartSectionData(
                                              color: const Color(0xFF26E5FF),
                                              value: user
                                                  .totalMerchantTransactionsValue,
                                              title:
                                                  'Merchant Txns\n ₹${user.totalMerchantTransactionsValue}',
                                              titleStyle: const TextStyle(
                                                backgroundColor: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              titlePositionPercentageOffset:
                                                  0.99,
                                              radius: 40),
                                          PieChartSectionData(
                                              color: const Color(0xFFFFCF26),
                                              value: user
                                                  .totalWalletTransactionsValue,
                                              title:
                                                  'Wallet Txns\n ₹${user.totalWalletTransactionsValue}',
                                              titleStyle: const TextStyle(
                                                backgroundColor: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              titlePositionPercentageOffset:
                                                  0.99,
                                              radius: 30),
                                          PieChartSectionData(
                                              color: const Color(0xFFEE2727),
                                              value: user.totalCashbackValue,
                                              title:
                                                  'Cashbacks Earned\n ₹${user.totalCashbackValue}',
                                              titleStyle: const TextStyle(
                                                backgroundColor: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              titlePositionPercentageOffset:
                                                  0.99,
                                              radius: 60),
                                        ])),
                                    Positioned.fill(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Balance",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
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
                        ])
                ],
              ),
            )),
      );
    });
  }
}
