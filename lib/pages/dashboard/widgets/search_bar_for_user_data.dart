import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_6_provider/apis/prepaid_card_data_api.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';

class SearchBarForUserData extends StatelessWidget {
  const SearchBarForUserData(
      {Key? key,
      required this.userId,
      required this.authToken,
      required this.rootContext,
      required this.userData})
      : super(key: key);
  final String userId;
  final String authToken;
  final BuildContext rootContext;
  final Map userData;
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    PrepaidCardData prepaidCardData = PrepaidCardData();
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 125, 203, 168)),
      child: TextField(
        autofocus: true,
        controller: searchController,
        textAlign: TextAlign.center,
        onSubmitted: (String value) {
          prepaidCardData.getUserDataForAdmin(userId, userData,
              searchController.text.toString(), authToken, rootContext);
        },
        decoration: InputDecoration(
          // icon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search for user prepaid data",
          hintStyle: const TextStyle(color: Colors.white),
          // ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              prepaidCardData.getUserDataForAdmin(userId, userData,
                  searchController.text.toString(), authToken, rootContext);
            },
          ),
        ),
      ),
    );
  }
}
