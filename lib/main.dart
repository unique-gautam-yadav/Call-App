import 'package:flutter/material.dart';
import 'package:slimmy_card/mainPage.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
