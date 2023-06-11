import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizDataStore extends ChangeNotifier {
  List finalQuizData = [];
  String userId = "";
  String authToken = "";
  List updatedQuizData = [];

  void setDataToQuizStore(
      List finalQuizDataT, String userIdT, String authTokenT) {
    finalQuizData = finalQuizDataT;
    userId = userIdT;
    authToken = authTokenT;
    updatedQuizData = finalQuizDataT;

    notifyListeners();
  }

  void updateQuizDataStore(List updatedQuizDataT) {
    updatedQuizData = updatedQuizDataT;
    notifyListeners();
  }
}
