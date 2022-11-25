import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrepaidDataStore extends ChangeNotifier {
  List dataArray = [];

  void setDataToPrepaidStore(List dataArrayT) {
    dataArray = dataArrayT;

    notifyListeners();
  }
}
