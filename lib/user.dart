import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String email = "";
  String password = "";

  String id = "";
  String firstName = "";
  String lastName = "";
  String token = "";
  String avatar = "";
  String creditCardState = "";

  void signIn(String emailT, String passwordT) {
    email = emailT;
    password = passwordT;
    notifyListeners();
  }

  void setUserData(String _idT, String firstNameT, String lastNameT,
      String tokenT, String avatarT, String creditCardStateT) {
    id = _idT;
    firstName = firstNameT;
    lastName = lastNameT;
    token = tokenT;
    avatar = avatarT;
    creditCardState = creditCardStateT;
    notifyListeners();
  }
}
