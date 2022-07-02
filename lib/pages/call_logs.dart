import 'package:flutter/material.dart';

import 'appbar.dart';

class CallLogs extends StatelessWidget {
  const CallLogs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: MyAppBar(
              title: "Phone",
              icon1: Icons.filter_alt_outlined,
              icon2: Icons.search_outlined,
              icon3: Icons.more_horiz,
              width: 40),
          backgroundColor: Colors.white),
      body: const Center(
          child: Icon(
        Icons.call,
        size: 100,
      )),
    );
  }
}
