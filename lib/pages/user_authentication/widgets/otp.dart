import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
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
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              width: ResponsiveLayout.isComputer(context)
                  ? MediaQuery.of(context).size.width - 300
                  : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(-4, 4),
                        color: Color.fromARGB(0, 255, 255, 255)),
                    // BoxShadow(
                    //     blurRadius: 4,
                    //     offset: Offset(8, 8),
                    //     color: Color.fromARGB(48, 0, 0, 0))
                  ]),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Image.network(
                        "https://res.cloudinary.com/basis-static/image/upload/v1609946823/logos/Basis_Green_Logo_2x.png",
                        scale: 20,
                      ),
                      Image.network(
                        "https://res.cloudinary.com/basis-static/image/upload/v1659020646/dev/undraw_setup_wizard_re_nday_1.png",
                        scale: 0.8,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Text(
                        "Verify Your Email Address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        "Enter the OTP received via email",
                      ),
                      Spacer(flex: 1),
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(230, 243, 243, 1)),
                          child: Container(
                            width: ResponsiveLayout.isComputer(context)
                                ? 600
                                : MediaQuery.of(context).size.width - 100,
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
                            ),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: ResponsiveLayout.isComputer(context)
                            ? 300
                            : MediaQuery.of(context).size.width > 500
                                ? 300
                                : MediaQuery.of(context).size.width - 200,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              verifyOtp(data["email"], data["token"]);
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                primary: const Color(0xff36c182)),
                            icon: const Icon(Icons.password),
                            label: const Text("Verify")),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
