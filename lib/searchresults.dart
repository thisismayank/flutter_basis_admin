import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/userdata.dart';
import 'package:flutter_application_6_provider/fetcheduserdetails.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  Widget cardTemplate(user, icon) {
    return SearchResultsDataCard(user: user, icon: icon);
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
              cardTemplate(user.id, Icons.perm_identity),
              cardTemplate(user.name, Icons.note),
              cardTemplate(user.email, Icons.email),
              cardTemplate(
                  'Rs. ${user.balance.toString()}', Icons.currency_rupee),
              cardTemplate(user.accountId, Icons.account_box),
              cardTemplate(user.customerId, Icons.woman),
              cardTemplate(user.cardActivationDate, Icons.credit_score_sharp),
              cardTemplate(user.sourceOfSignUp, Icons.mobile_friendly),
              cardTemplate(user.basisUserSince, Icons.login),
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
                  PieChart(PieChartData(centerSpaceRadius: 70, sections: [
                    PieChartSectionData(
                        color: const Color(0xFF26E5FF),
                        value: user.totalMerchantTransactionsValue,
                        title:
                            'Merchant Txns\n ₹${user.totalMerchantTransactionsValue}',
                        radius: 40),
                    PieChartSectionData(
                        color: const Color(0xFFFFCF26),
                        value: user.totalWalletTransactionsValue,
                        title:
                            'Wallet Txns\n ₹${user.totalWalletTransactionsValue}',
                        radius: 26),
                  ])),
                  Positioned.fill(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Current Balance"),
                      Text(
                        '₹ ${user.balance.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
                ]),
              ),
            ],
          )
              // child: Column(
              //   children: [
              //     Text(user.name),
              //     Text(user.id),
              //     Text(user.email),
              //     Text(user.balance.toString()),
              //     Text(user.accountId),
              //     Text(user.customerId),
              //     Text(user.cardActivationDate),
              //     Text(user.sourceOfSignUp),
              //     Text(user.basisUserSince)
              //   ],
              // ),
              ),
        ),
      );
    });
  }
}
