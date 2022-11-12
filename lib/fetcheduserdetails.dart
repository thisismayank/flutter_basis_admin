import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchResultsDataCard extends StatelessWidget {
  final String user;
  final IconData icon;
  const SearchResultsDataCard(
      {Key? key, required this.user, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 2.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Icon(icon),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            user,
            overflow: TextOverflow.fade,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: user));
              }),
        ),
      ]),
    );
  }
}
