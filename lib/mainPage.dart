import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slimmy_card/pages/get_permission.dart';
import 'package:slimmy_card/pages/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool permissionState;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) => checkStatus());
    super.initState();
  }

  checkStatus() async {
    bool temp1 = await Permission.contacts.isGranted;
    bool temp2 = await Permission.phone.isGranted;

    setState(() {
      permissionState = (temp1 && temp2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return permissionState == null
        ? Scaffold(
            body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitRotatingCircle(
                  color: Theme.of(context).primaryColor, size: 75),
              const SizedBox(height: 10),
              const Text("Loading...")
            ],
          ))
        : permissionState
            ? const HomePage()
            : const GetPermission();
  }
}
