import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier {
  String id = "";
  String name = "";
  String email = "";
  String customerId = "";
  String accountId = "";
  double balance = 0.0;
  String cardActivationDate = "";
  String sourceOfSignUp = "";
  String basisUserSince = "";
  double totalMerchantTransactionsValue = 0.0;
  double totalWalletTransactionsValue = 0.0;

  void setUserDataForAdmin(
      String idT,
      String nameT,
      String emailT,
      String customerIdT,
      String accountIdT,
      double balanceT,
      String cardActivationDateT,
      String sourceOfSignUpT,
      String basisUserSinceT,
      String totalMerchantTransactionsValueT,
      String totalWalletTransactionsValueT) {
    id = idT;
    name = nameT;
    email = emailT;
    customerId = customerIdT;
    accountId = accountIdT;
    balance = balanceT;
    cardActivationDate = cardActivationDateT;
    sourceOfSignUp = sourceOfSignUpT;
    basisUserSince = basisUserSinceT;
    totalMerchantTransactionsValue =
        double.parse(totalMerchantTransactionsValueT);
    totalWalletTransactionsValue = double.parse(totalWalletTransactionsValueT);

    notifyListeners();
  }
}
