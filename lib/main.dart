import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/dashboard.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/prepaid_card_user_analytics.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/global_analytics_page.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/email.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/otp.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:flutter_application_6_provider/pages/post/widgets/post_card.dart';
import 'package:flutter_application_6_provider/prepaiddatastore.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/search_results.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';

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
        "/global": (context) {
          print("ISKE ANDAR");
          return const GlobalAnalyticsPage();
        },
        "/prepaid": ((context) {
          print("INSIDE");
          return const PrepaidDataTable();
        })
      },
    ),
  ));
}
