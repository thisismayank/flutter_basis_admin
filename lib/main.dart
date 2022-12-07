import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/dashboard.dart';
import 'package:flutter_application_6_provider/globalanalytics.dart';
import 'package:flutter_application_6_provider/globalanalyticspage.dart';
import 'package:flutter_application_6_provider/home.dart';
import 'package:flutter_application_6_provider/otp.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/postcard.dart';
import 'package:flutter_application_6_provider/prepaiddatastore.dart';
import 'package:flutter_application_6_provider/prepaiddatatable.dart';
import 'package:flutter_application_6_provider/searchresults.dart';
import 'package:flutter_application_6_provider/user.dart';
import 'package:flutter_application_6_provider/userdata.dart';

import 'package:provider/provider.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
        alignment: Alignment.center,
        child: Text(
          'Error\n${details.exception}',
          style: const TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          textAlign: TextAlign.center,
        ));
  };
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => User()),
      ChangeNotifierProvider(create: (_) => Post()),
      ChangeNotifierProvider(create: (_) => UserData()),
      ChangeNotifierProvider(create: (_) => GlobalAnalytics()),
      ChangeNotifierProvider(create: (_) => PrepaidDataStore())
    ],
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/otp": (context) => const OTP(),
        "/dashboard": (context) => const Dashboard(),
        "/post": (context) => const PostCard(),
        "/search": (context) => SearchResults(),
        "/global": (context) => const GlobalAnalyticsPage(),
        "/prepaid": ((context) => const PrepaidDataTable())
      },
    ),
  ));
}
