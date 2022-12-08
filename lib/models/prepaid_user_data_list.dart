import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrepaidDataStore extends ChangeNotifier {
  List dataArray = [];
  List allUsersWhoActivatedCardList = [];
  void setDataToPrepaidStore(List dataArrayT) {
    dataArray = dataArrayT;

    notifyListeners();
  }

  void allUsersWhoActivatedCardListMethod(allUsersWhoActivatedCardListT) {
    allUsersWhoActivatedCardList = allUsersWhoActivatedCardListT;
  }
}
