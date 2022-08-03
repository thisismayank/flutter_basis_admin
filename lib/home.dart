import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_6_provider/user.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
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
      print(responseData);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: const Color(0xff36c182),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  "https://res.cloudinary.com/basis-static/image/upload/v1659020646/dev/undraw_setup_wizard_re_nday_1.png"),
              const SizedBox(
                height: 32,
              ),
              // const Text(
              //   "Enter your email address",
              //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              // ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                    hintText: "Please enter your email address",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff36c182)))),
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
            ],
          ),
        ),
      ),
    );
  }
}
