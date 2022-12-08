import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Post extends ChangeNotifier {
  String id = "";
  String body = "";
  String createdAt = "";
  String userId = "";
  String userName = "";

  void setAPost(String idT, String bodyT, String createdAtT, String userIdT,
      String userNameT) {
    id = idT;
    body = bodyT;
    createdAt = createdAtT;
    userId = userIdT;
    userName = userNameT;
    notifyListeners();
  }
}
