import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MintyDataStore extends ChangeNotifier {
  double countOfChats = 0.0;
  List finalChatList = [];
  double uniqueUserIds = 0.0;
  void setDataToMintyStore(
      double countOfChatsT, List finalChatListT, double uniqueUserIdsT) {
    countOfChats = countOfChatsT;
    finalChatList = finalChatListT;
    uniqueUserIds = uniqueUserIdsT;

    notifyListeners();
  }
}
