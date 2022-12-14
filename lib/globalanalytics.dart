import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalAnalytics extends ChangeNotifier {
  double ccStateActivated = 0.0;
  double ccYesterday = 0.0;
  double ccStateInProgress = 0.0;
  double ccStateManualCheck = 0.0;
  double ccPhysicallyActivated = 0.0;
  double rewardRedeemed = 0.0;
  double rewardLocked = 0.0;
  double txnWallet = 0.0;
  double txnTransactions = 0.0;
  double txnCashbacks = 0.0;
  double totalStates = 0.0;
  double totalRewards = 0.0;
  double totalTransactions = 0.0;
  double ipBasicDetails = 0.0;
  double ipPan = 0.0;
  double ipAddress = 0.0;
  double ipOtp = 0.0;

  void setGlobalDataForAdmin(
    String ccStateActivatedT,
    String ccYesterdayT,
    String ccStateInProgressT,
    String ccStateManualCheckT,
    String ccPhysicallyActivatedT,
    String rewardRedeemedT,
    String rewardLockedT,
    String txnWalletT,
    String txnTransactionsT,
    String txnCashbacksT,
    String totalStatesT,
    String totalRewardsT,
    String totalTransactionsT,
    String ipBasicDetailsT,
    String ipPanT,
    String ipAddressT,
    String ipOtpT,
  ) {
    ccStateActivated = double.parse(ccStateActivatedT);
    ccYesterday = double.parse(ccYesterdayT);
    ccStateInProgress = double.parse(ccStateInProgressT);
    ccStateManualCheck = double.parse(ccStateManualCheckT);
    ccPhysicallyActivated = double.parse(ccPhysicallyActivatedT);
    rewardLocked = double.parse(rewardLockedT);
    rewardRedeemed = double.parse(rewardRedeemedT);
    txnWallet = double.parse(txnWalletT);
    txnTransactions = double.parse(txnTransactionsT);
    txnCashbacks = double.parse(txnCashbacksT);
    totalStates = double.parse(totalStatesT);
    totalRewards = double.parse(totalRewardsT);
    totalTransactions = double.parse(totalTransactionsT);
    ipBasicDetails = double.parse(ipBasicDetailsT);
    ipPan = double.parse(ipPanT);
    ipAddress = double.parse(ipAddressT);
    ipOtp = double.parse(ipOtpT);

    notifyListeners();
  }
}
