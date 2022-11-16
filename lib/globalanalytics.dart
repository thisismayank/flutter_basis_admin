import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalAnalytics extends ChangeNotifier {
  double ccStateActivated = 0.0;
  double ccStateInProgress = 0.0;
  double ccStateManualCheck = 0.0;
  double rewardRedeemed = 0.0;
  double rewardLocked = 0.0;
  double txnWallet = 0.0;
  double txnTransactions = 0.0;
  double txnCashbacks = 0.0;
  double totalStates = 0.0;
  double totalRewards = 0.0;
  double totalTransactions = 0.0;

  void setGlobalDataForAdmin(
      String ccStateActivatedT,
      String ccStateInProgressT,
      String ccStateManualCheckT,
      String rewardRedeemedT,
      String rewardLockedT,
      String txnWalletT,
      String txnTransactionsT,
      String txnCashbacksT,
      String totalStatesT,
      String totalRewardsT,
      String totalTransactionsT) {
    ccStateActivated = double.parse(ccStateActivatedT);
    ccStateInProgress = double.parse(ccStateInProgressT);
    ccStateManualCheck = double.parse(ccStateManualCheckT);
    rewardLocked = double.parse(rewardLockedT);
    rewardRedeemed = double.parse(rewardRedeemedT);
    txnWallet = double.parse(txnWalletT);
    txnTransactions = double.parse(txnTransactionsT);
    txnCashbacks = double.parse(txnCashbacksT);
    totalStates = double.parse(totalStatesT);
    totalRewards = double.parse(totalRewardsT);
    totalTransactions = double.parse(totalTransactionsT);

    notifyListeners();
  }
}
