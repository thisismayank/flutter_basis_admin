import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/dashboard.dart';
import 'package:flutter_application_6_provider/home.dart';
import 'package:flutter_application_6_provider/otp.dart';
import 'package:flutter_application_6_provider/post.dart';
import 'package:flutter_application_6_provider/postcard.dart';
import 'package:flutter_application_6_provider/user.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => User()),
      ChangeNotifierProvider(create: (_) => Post())
    ],
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/otp": (context) => const OTP(),
        "/dashboard": (context) => const Dashboard(),
        "/post": (context) => const PostCard(),
      },
    ),
  ));
}
