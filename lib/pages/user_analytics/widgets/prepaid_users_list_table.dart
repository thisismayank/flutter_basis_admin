import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/apis/user_data_api.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/dashboard.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PrepaidDataTable extends StatelessWidget {
  const PrepaidDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passedData = ModalRoute.of(context)?.settings.arguments as Map;
    String authToken = passedData["authToken"];
    String userId = passedData["userId"];
    BuildContext contextRoot = passedData["context"];

    void getUserDataForAdmin(selectedUserId) async {
      UserPrepaidCardData userPrepaidCardData = UserPrepaidCardData();
      userPrepaidCardData.getUserPrepaidData(
          selectedUserId, userId, authToken, contextRoot);
    }

    TextStyle titles = const TextStyle(
        fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 16);

    return Consumer<PrepaidDataStore>(builder: (context, prepaidData, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Users from the last 24 hours'),
            backgroundColor: const Color(0xff36c182),
          ),
          body: ListView(
            children: [
              Center(
                child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 171, 235, 173)),
                    columns: [
                      DataColumn(label: Text('Name', style: titles)),
                      DataColumn(
                          label: Expanded(
                              child: Text(
                        'Phone Number',
                        style: titles,
                        softWrap: true,
                      ))),
                      DataColumn(
                          label: Expanded(
                              child: Text(
                        'Card Activated',
                        style: titles,
                        softWrap: true,
                      )))
                    ],
                    rows: prepaidData.dataArray
                        .map((prepaidUserdData) => DataRow(cells: [
                              DataCell(
                                  Text('${prepaidUserdData["name"]}',
                                      style: TextStyle(
                                          fontWeight:
                                              prepaidUserdData["flowComplete"]
                                                  ? FontWeight.normal
                                                  : FontWeight.bold)),
                                  onTap: () => getUserDataForAdmin(
                                      prepaidUserdData["userId"])),
                              DataCell(
                                  Text('${prepaidUserdData["phoneNumber"]}',
                                      style: TextStyle(
                                          fontWeight:
                                              prepaidUserdData["flowComplete"]
                                                  ? FontWeight.normal
                                                  : FontWeight.bold)),
                                  onTap: () => getUserDataForAdmin(
                                      prepaidUserdData["userId"])),
                              DataCell(
                                  Text(
                                    '${prepaidUserdData["flowComplete"]}',
                                    style: TextStyle(
                                        fontWeight:
                                            prepaidUserdData["flowComplete"]
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                        color: prepaidUserdData["flowComplete"]
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                  onTap: () => getUserDataForAdmin(
                                      prepaidUserdData["userId"])),
                            ]))
                        .toList()),
              )
            ],
          ));
    });
  }
}
