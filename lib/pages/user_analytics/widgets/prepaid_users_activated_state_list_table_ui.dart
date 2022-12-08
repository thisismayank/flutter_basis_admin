import 'dart:convert';
import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/apis/user_data_api.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/dashboard.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PrepaidCardActivatedDataTable extends StatelessWidget {
  const PrepaidCardActivatedDataTable(
      {Key? key,
      required this.authToken,
      required this.userId,
      required this.contextRoot})
      : super(key: key);
  final String authToken;
  final String userId;
  final BuildContext contextRoot;
  @override
  Future<Widget> getActivatedUsersData() async {
    PrepaidCardData prepaidCardDataApi = PrepaidCardData();
    await prepaidCardDataApi.getAllUsersWhoActivatedPowerCard(
        authToken, contextRoot, 0, 200);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    UserPrepaidCardData userPrepaidCardData = UserPrepaidCardData();

    TextStyle titles = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Consumer<PrepaidDataStore>(builder: (context, prepaidData, child) {
      return FutureBuilder<Widget?>(
          future: getActivatedUsersData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Center(
                    child: DataTable(
                        columnSpacing: 16,
                        headingRowColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 217, 236, 217)),
                        columns: [
                          DataColumn(label: Text('', style: titles)),
                          DataColumn(label: Text('Name', style: titles)),
                          DataColumn(
                              label: Expanded(
                                  child: Text(
                            'Email',
                            style: titles,
                            softWrap: true,
                          ))),
                        ],
                        rows: prepaidData.allUsersWhoActivatedCardList
                            .map((prepaidUserdData) => DataRow(cells: [
                                  DataCell(
                                      CircleAvatar(
                                        radius: 15,
                                        child: Text(
                                            '${prepaidUserdData["firstName"].substring(0, 1).toUpperCase()}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        backgroundColor: Colors.primaries[
                                            Random().nextInt(
                                                Colors.primaries.length)],
                                      ),
                                      onTap: () => userPrepaidCardData
                                          .getUserPrepaidData(
                                              prepaidUserdData["_id"],
                                              userId,
                                              authToken,
                                              contextRoot)),
                                  DataCell(
                                      ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxWidth: 80),
                                          child: Text(
                                              '${prepaidUserdData["firstName"]}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      onTap: () => userPrepaidCardData
                                          .getUserPrepaidData(
                                              prepaidUserdData["_id"],
                                              userId,
                                              authToken,
                                              contextRoot)),
                                  DataCell(
                                      Text('${prepaidUserdData["email"]}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      onTap: () => userPrepaidCardData
                                          .getUserPrepaidData(
                                              prepaidUserdData["_id"],
                                              userId,
                                              authToken,
                                              contextRoot)),
                                ]))
                            .toList()),
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator(
                color: Colors.green,
              );
            }
          });
    });
  }
}
