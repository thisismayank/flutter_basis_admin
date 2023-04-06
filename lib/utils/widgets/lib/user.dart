import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class UserUtilsLib {
  void logoutUser(context) async {
    try {
      try{
      final sharedPreferenceInstance = await SharedPreferences.getInstance();
      await sharedPreferenceInstance.remove("userId");
      await sharedPreferenceInstance.remove("token");
      await sharedPreferenceInstance.remove("avatar");
      await sharedPreferenceInstance.remove("creditCardState");
      await sharedPreferenceInstance.remove("firstName");
      await sharedPreferenceInstance.remove("lastName");
      await sharedPreferenceInstance.remove("email");
      }catch(error){
        print('logout inner shared pref $error');
      }
      Navigator.pushNamed(context, "/");
    } catch (error) {
      print('logout $error');
    }
  }
}
