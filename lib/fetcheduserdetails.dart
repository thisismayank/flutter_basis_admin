import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchResultsDataCard extends StatelessWidget {
  final String user;
  final IconData icon;
  final bool showCopy;
  const SearchResultsDataCard(
      {Key? key,
      required this.user,
      required this.icon,
      required this.showCopy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2.0),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Icon(
            icon,
            size: 14,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            user,
            style: showCopy
                ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                : const TextStyle(fontWeight: FontWeight.w300),
            overflow: TextOverflow.fade,
          ),
        ),
        showCopy
            ? Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    iconSize: 12,
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: user));
                    }),
                alignment: Alignment.centerRight,
              )
            : const SizedBox(
                height: 40,
              ),
      ]),
    );
  }
}
