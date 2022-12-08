import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTP extends StatelessWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    var otpController = TextEditingController();

    void verifyOtp(email, token) async {
      var uri = Uri.parse("https://api.getbasis.co/v6.4/users/email/verify");
      var response = await http.put(uri, body: {
        "email": data["email"].toString(),
        "token": data["token"].toString(),
        "verificationCode": otpController.text.toString()
      });
      Map responseData = jsonDecode(response.body);

      Provider.of<User>(context, listen: false).setUserData(
        responseData["results"]["user"]["_id"],
        responseData["results"]["user"]["firstName"],
        responseData["results"]["user"]["lastName"],
        responseData["results"]["user"]["token"],
        responseData["results"]["user"]["avatar"],
        responseData["results"]["user"]["creditCardState"],
        responseData["results"]["user"]["email"],
      );

      final sharedPreferenceInstance = await SharedPreferences.getInstance();
      await sharedPreferenceInstance.setString(
          "userId", responseData["results"]["user"]["_id"]);
      await sharedPreferenceInstance.setString(
          "token", responseData["results"]["user"]["token"]);
      await sharedPreferenceInstance.setString(
          "avatar", responseData["results"]["user"]["avatar"]);
      await sharedPreferenceInstance.setString("creditCardState",
          responseData["results"]["user"]["creditCardState"]);
      await sharedPreferenceInstance.setString(
          "firstName", responseData["results"]["user"]["firstName"]);
      await sharedPreferenceInstance.setString(
          "lastName", responseData["results"]["user"]["lastName"]);
      await sharedPreferenceInstance.setString(
          "email", responseData["results"]["user"]["email"]);

      Navigator.pushNamed(context, "/dashboard",
          arguments: {"userData": responseData["results"]["user"]});
    }

    return Consumer<User>(builder: (context, user, _) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("OTP"),
            centerTitle: true,
            backgroundColor: const Color(0xff36c182),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                    "https://res.cloudinary.com/basis-static/image/upload/v1659020646/dev/undraw_setup_wizard_re_nday_1.png"),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Verify Your Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Enter the OTP received via email",
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(230, 243, 243, 1)),
                    child: TextField(
                      autofocus: true,
                      controller: otpController,
                      onSubmitted: (String value) {
                        verifyOtp(data["email"], data["token"]);
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter OTP",
                      ),
                    )),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      verifyOtp(data["email"], data["token"]);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        primary: const Color(0xff36c182)),
                    icon: const Icon(Icons.password),
                    label: const Text("Verify"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
