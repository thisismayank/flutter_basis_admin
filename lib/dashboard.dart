import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/user.dart';
import 'package:flutter_application_6_provider/webview.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    // print(data);
    String token = data["userData"]["token"];
    String userId = data["userData"]["_id"];
    String authToken = '$userId,$token';

    void getPosts() async {
      var uri = Uri.parse("https://api.getbasis.co/v7/posts");

      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});
      // print(response.body);
      Map responseData = jsonDecode(response.body);
      print(responseData);
      Provider.of<Post>(context, listen: false).setAPost(
          responseData["results"][0]["_id"],
          responseData["results"][0]["body"],
          responseData["results"][0]["createdAt"],
          responseData["results"][0]["postOwnerUserId"],
          responseData["results"][0]["userName"]);

      Navigator.pushNamed(context, "/post");
    }

    void accessDevTo() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WebViewPage("https://dev.to/", "DEV")));
    }

    void accessBasisWebApp() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WebViewPage("https://app.getbasis.co", "Basis")));
    }

    void accessPWA() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(authToken, authToken);

      // print("authToken" + authToken);
      var uri =
          Uri.parse("https://api.getbasis.co/v6.4/bpcards?isfromweb=true");
      var response =
          await http.get(uri, headers: {"Authorization": 'Bearer $authToken'});

      Map responseData = jsonDecode(response.body);
      String pwaUrl = responseData["results"]["url"];

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(pwaUrl, "Basis Power Card")));
    }

    return Consumer<User>(builder: (context, user, child) {
      return MaterialApp(
          home: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Dashboard"),
          backgroundColor: const Color(0xff36c182),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                  radius: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Divider(
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              const Text("First name",
                  style: TextStyle(color: Colors.grey, letterSpacing: 2.0)),
              Text(
                user.firstName,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.amberAccent,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Text("Last NAME",
                  style: TextStyle(color: Colors.grey, letterSpacing: 2.0)),
              Text(
                user.lastName,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.amberAccent,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Text("Email",
                  style: TextStyle(color: Colors.grey, letterSpacing: 2.0)),
              Text(
                user.email,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.amberAccent,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Text("Credit Card State",
                  style: TextStyle(color: Colors.grey, letterSpacing: 2.0)),
              Text(
                user.creditCardState,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.amberAccent,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                  onPressed: () {
                    getPosts();
                  },
                  style: ElevatedButton.styleFrom(),
                  icon: const Icon(Icons.post_add),
                  label: const Text("Get Post")),
              ElevatedButton.icon(
                  onPressed: () {
                    accessBasisWebApp();
                  },
                  icon: const Icon(CupertinoIcons.rocket),
                  label: const Text("Get Basis")),
              ElevatedButton.icon(
                  onPressed: () {
                    accessDevTo();
                  },
                  icon: const Icon(CupertinoIcons.rocket),
                  label: const Text("Access dev.to")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            accessPWA();
          },
          backgroundColor: const Color(0xff36c182),
          icon: const Icon(Icons.credit_card),
          label: const Text("Go to Power Card"),
        ),
      ));
    });
  }
}


    //         ElevatedButton.icon(
    //             onPressed: () {
    //               getPosts();
    //             },
    //             icon: const Icon(Icons.post_add),
    //             label: const Text("Get Post")),