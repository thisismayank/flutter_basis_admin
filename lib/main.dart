import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/minty.dart';
import 'package:flutter_application_6_provider/models/quiz.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/dashboard.dart';
import 'package:flutter_application_6_provider/models/global_analytics.dart';
import 'package:flutter_application_6_provider/pages/dashboard/widgets/quiz_data_wrapper.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/prepaid_card_user_analytics_ui.dart';
import 'package:flutter_application_6_provider/pages/global_analytics/widgets/global_analytics_page_ui.dart';
import 'package:flutter_application_6_provider/pages/minty/chat_messages_wrapper.dart';
import 'package:flutter_application_6_provider/pages/minty/list_chats.dart';
import 'package:flutter_application_6_provider/pages/panels/widgets/map_wrapper.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_activated_state_list_table_ui.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/email.dart';
import 'package:flutter_application_6_provider/pages/user_authentication/widgets/otp.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:flutter_application_6_provider/pages/post/widgets/post_card.dart';
import 'package:flutter_application_6_provider/models/prepaid_user_data_list.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/prepaid_users_list_table.dart';
import 'package:flutter_application_6_provider/pages/user_analytics/widgets/search_results.dart';
import 'package:flutter_application_6_provider/models/user_authentication.dart';
import 'package:flutter_application_6_provider/models/user_prepaid_card_data.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';
import 'package:flutter_application_6_provider/responsive/widget_tree.dart';

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
      ChangeNotifierProvider(create: (_) => PrepaidDataStore()),
      ChangeNotifierProvider(create: (_) => MintyDataStore()),
      ChangeNotifierProvider(create: (_) => QuizDataStore())
    ],
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Email(),
        "/otp": (context) => const OTP(),
        "/dashboard": (context) => const WidgetTree(),
        "/quiz": (context) => const QuizDataWrapper(),

        "/minty": (context) => const ListChats(),
        "/minty/messages": (context) {
          final passedData = ModalRoute.of(context)?.settings.arguments as Map;
          // List finalPassedData = jsonDecode(passedData["messages"]);
          // print('passedData $finalPassedData');
          return ChatMessagesWrapper(messages: passedData);
        },
        // "/minty": (context) {

        //   return ListChats(
        //     // authToken: passedData["authToken"],
        //     authToken:
        //         "61607e002aaecb208788c0e0,eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNjA3ZTAwMmFhZWNiMjA4Nzg4YzBlMCIsImlhdCI6MTY4MDE2NjM0NCwiZXhwIjoxNjgyNzU4MzQ0fQ.PBScOUXYLMR3QTVXLQh7GsXjnqbLGe2zo20BdrhBdbc",
        //     rootContext: context,
        //   );
        // },
        "/post": (context) => const PostCard(),
        "/search": (context) {
          final passedData = ModalRoute.of(context)?.settings.arguments as Map;

          return SearchResults(
            authToken: passedData["authToken"],
            userData: passedData,
            userInformation: 0,
            rootContext: context,
          );
        },
        "/map": (context) {
          final passedData = ModalRoute.of(context)?.settings.arguments as Map;

          return MapWrapper(
            authToken: passedData["authToken"],
            rootContext: context,
            userData: passedData,
          );
        },
        "/global": (context) => const GlobalAnalyticsPage(
              userId: "",
              authToken: "",
            ),
        "/prepaid": (context) => PrepaidDataTable(
            authToken: '',
            userData: {},
            userInformation: 0,
            rootContext: context),
        // "/prepaid/activated": (context) => const PrepaidCardActivatedDataTable()
      },
    ),
  ));
}
