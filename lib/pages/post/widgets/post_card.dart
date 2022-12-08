import 'package:flutter/material.dart';
import 'package:flutter_application_6_provider/models/post.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Post>(builder: (context, post, child) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Post Card'),
            backgroundColor: const Color(0xff36c182),
          ),
          body: Card(
            child: Column(
              children: [Text(post.body)],
            ),
          ),
        ),
      );
    });
  }
}
