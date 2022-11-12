import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/userdata.dart';
import 'package:flutter_application_6_provider/fetcheduserdetails.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  Widget cardTemplate(user, icon, showCopyIcon) {
    return SearchResultsDataCard(
      user: user,
      icon: icon,
      showCopy: showCopyIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, user, child) {
      // print(user);
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Search Results'),
            backgroundColor: const Color(0xff36c182),
          ),
          body: Card(
              child: Column(
            children: [
              cardTemplate(user.id, Icons.perm_identity, true),
              cardTemplate(user.name, Icons.note, true),
              cardTemplate(user.email, Icons.email, true),
              cardTemplate(user.accountId, Icons.account_box, true),
              cardTemplate(user.customerId, Icons.woman, true),
              cardTemplate(user.cardId, Icons.credit_card, true),
              cardTemplate(
                  user.creditCardState, Icons.tab_unselected_rounded, false),
              cardTemplate(user.cardActivationDate,
                  Icons.calendar_month_outlined, false),
              cardTemplate(user.sourceOfSignUp, Icons.mobile_friendly, false),
              cardTemplate(user.basisUserSince, Icons.login, false),
              const Divider(
                height: 40,
                thickness: 40,
              ),
              const Text(
                "Transactions Breakdown",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: Stack(children: [
                  PieChart(PieChartData(
                      centerSpaceRadius: 70,
                      startDegreeOffset: -90,
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
                            radius: 20),
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
                ]),
              ),
            ],
          )),
        ),
      );
    });
  }
}
