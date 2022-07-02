import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slimmy_card/pages/call_logs.dart';
import 'package:slimmy_card/pages/contacts.dart';
import 'package:slimmy_card/pages/keypad.dart';
import 'package:slimy_card/slimy_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor),
          currentIndex: selectIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.keyboard_alt), label: "KeyPad"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call Logs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: "Contacts"),
          ],
          onTap: (int index) {
            setState(() {
              selectIndex = index;
            });
          }),
      body: IndexedStack(
        index: selectIndex,
        children: const [KeyPad(), CallLogs(), Contacts()],
      ),
    );
  }
}
