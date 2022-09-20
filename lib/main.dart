import 'package:flutter/material.dart';
import 'package:slimmy_card/pages/contacts.dart';
import 'package:slimmy_card/pages/get_permission.dart';
import 'package:slimmy_card/pages/home.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      initialRoute: "/permission",
      debugShowCheckedModeBanner: false,
      routes: {
        "/permission": (context) => const GetPermission(),
      },
    );
  }
}
