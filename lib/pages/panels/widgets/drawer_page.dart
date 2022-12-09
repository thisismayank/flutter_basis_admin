import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_6_provider/responsive/responsive_layout.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class ButtonsInfo {
  String title;
  IconData icon;
  ButtonsInfo({required this.title, required this.icon});
}

int _currentIndex = 0;
List<ButtonsInfo> _buttonNames = [
  ButtonsInfo(title: "Item", icon: Icons.home),
  ButtonsInfo(title: "Main", icon: Icons.mail),
  ButtonsInfo(title: "Dashboard", icon: Icons.dangerous),
  ButtonsInfo(title: "About", icon: Icons.ac_unit),
  ButtonsInfo(title: "You", icon: Icons.yard),
  ButtonsInfo(title: "Mayank", icon: Icons.mail_lock_sharp),
  ButtonsInfo(title: "Arya", icon: Icons.access_alarm_rounded)
];

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xff36c182),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                ListTile(
                  title: const Text(
                    "Admin Menu",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
                  ),
                  trailing: ResponsiveLayout.isComputer(context)
                      ? null
                      : IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                ),
                ...List.generate(
                    _buttonNames.length,
                    (index) => Column(
                          children: [
                            Container(
                              decoration: index == _currentIndex
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black)
                                  : null,
                              child: ListTile(
                                  title: Text(
                                    _buttonNames[index].title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Icon(
                                      _buttonNames[index].icon,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 0.1,
                            )
                          ],
                        ))
              ])),
        ));
  }
}
