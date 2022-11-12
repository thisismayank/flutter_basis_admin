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
  double totalCashbackValue = 0.0;
  String cardId = "";
  String creditCardState = "";

  void setUserDataForAdmin(
      String idT,
      String nameT,
      String emailT,
      String customerIdT,
      String accountIdT,
      String balanceT,
      String cardActivationDateT,
      String sourceOfSignUpT,
      String basisUserSinceT,
      String totalMerchantTransactionsValueT,
      String totalWalletTransactionsValueT,
      String totalCashbackValueT,
      String cardIdT,
      String creditCardStateT) {
    id = idT;
    name = nameT;
    email = emailT;
    customerId = customerIdT;
    accountId = accountIdT;
    cardId = cardIdT;
    creditCardState = creditCardStateT;
    balance = double.parse(balanceT);
    cardActivationDate = cardActivationDateT;
    sourceOfSignUp = sourceOfSignUpT;
    basisUserSince = basisUserSinceT;
    totalMerchantTransactionsValue =
        double.parse(totalMerchantTransactionsValueT);
    totalWalletTransactionsValue = double.parse(totalWalletTransactionsValueT);
    totalCashbackValue = double.parse(totalCashbackValueT);

    notifyListeners();
  }
}
