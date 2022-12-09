import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  void checkIfLoggedIn() async {
    // super.initState();

    final sharedPreferenceInstance = await SharedPreferences.getInstance();

    String? userId = sharedPreferenceInstance.getString("userId");
    String? tokenT = sharedPreferenceInstance.getString("token");
    String? avatar = sharedPreferenceInstance.getString("avatar");
    String? creditCardState =
        sharedPreferenceInstance.getString("creditCardState");
    String? firstName = sharedPreferenceInstance.getString("firstName");
    String? lastName = sharedPreferenceInstance.getString("lastName");
    String? email = sharedPreferenceInstance.getString("email");

    String token = tokenT != null ? tokenT.toString() : "";

    if (userId?.length == 24) {
      //   String authToken = '$userId,$token';
      //   var uri = Uri.parse('https://api.getbasis.co/v6.4/users/$userId');
      //   var response =
      //       await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
      //   Map responseData = jsonDecode(response.body);
      //   print(responseData["results"]["user"]["creditCardState"]);
      //   print(responseData["results"]["user"]["firstName"]);
      //   print(responseData["results"]["user"]["lastName"]);
      //   print(responseData["results"]["user"]["_id"]);
      //   print(responseData["results"]["user"]["avatar"]);

      //   // print(responseData["results"]["user"]["token"]);
      //   if (token != "") {
      Provider.of<User>(context, listen: false).setUserData(
          userId.toString(),
          firstName.toString(),
          lastName.toString(),
          token.toString(),
          avatar.toString(),
          creditCardState.toString(),
          email.toString());

      Provider.of<User>(context, listen: false).signIn(email.toString(), "");
      Navigator.pushNamed(context, "/dashboard", arguments: {
        "userData": {
          "token": token,
          "_id": userId,
          "avatar": avatar,
          "firstName": firstName,
          "lastName": lastName,
          "email": email
        }
      });
    }

    // }
    // }
  }

  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void submitEmail() async {
      var uri = Uri.parse("https://api.getbasis.co/v6.4/users/email");
      var response = await http
          .post(uri, body: {"email": emailController.text.toString()});

      Map responseData = jsonDecode(response.body);

      Navigator.pushNamed(context, "/otp", arguments: {
        "email": emailController.text.toString(),
        "token": responseData["results"]["token"]
      });
    }

    print("IT IT");
    return Scaffold(
      body: SizedBox(
        height: 600,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(children: [
                  Expanded(
                    child: Image.network(
                        "https://res.cloudinary.com/basis-static/image/upload/v1659020646/dev/undraw_setup_wizard_re_nday_1.png"),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // const Text(
                  //   "Enter your email address",
                  //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  // ),
                  // GoogleSignInWidget(),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(230, 243, 243, 1)),
                      child: TextField(
                        autofocus: true,
                        controller: emailController,
                        onSubmitted: (String value) {
                          submitEmail();
                        },
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Please enter your email address",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<User>(context, listen: false).signIn(
                            emailController.text.toString(),
                            passwordController.text.toString());

                        submitEmail();
                        // Navigator.pushNamed(context, "/dashboard");
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          primary: const Color(0xff36c182)),
                      icon: const Icon(Icons.login),
                      label: const Text("Continue")),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Need help? Contact support@getbasis.co")
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
