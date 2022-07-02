import 'package:flutter/material.dart';
import 'package:slimmy_card/pages/contacts.dart';
import 'package:slimmy_card/pages/home.dart';

void main() {
  runApp(MyApp());
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
      initialRoute: "/contact",
      debugShowCheckedModeBanner: false,
      routes: {
        // "/": (context) => const HomePage(),
        "/contact": (context) => const Contacts(),
      },
    );
  }
}
