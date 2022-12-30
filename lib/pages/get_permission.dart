// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slimmy_card/mainPage.dart';
import 'package:slimmy_card/pages/home.dart';

class GetPermission extends StatefulWidget {
  const GetPermission({Key key}) : super(key: key);

  @override
  State<GetPermission> createState() => _GetPermissionState();
}

class _GetPermissionState extends State<GetPermission> {
  @override
  Widget build(BuildContext context) {

    requestPermissions() async {
      bool contactPermission = await Permission.contacts.isGranted;
      bool phonePermission = await Permission.phone.isGranted;

      if (!contactPermission) {
        PermissionStatus t = await Permission.contacts.request();
        // if (t.isDenied || t.isPermanentlyDenied) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //       content: Text("We can't take you without permissions.")));
        // }

        contactPermission = t.isGranted;
      }

      if (!phonePermission) {
        PermissionStatus t = await Permission.phone.request();
        // if (t.isDenied || t.isPermanentlyDenied) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //       content: Text("We can't take you without permissions.")));
        // }
        phonePermission = t.isGranted;
      }

      if (phonePermission && contactPermission) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
      } else {
        Navigator.pop(context);
        // print("$phonePermission && $contactPermission");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("We can't take you without permissions.")));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 75, 8, 8),
              child: Text(
                "Please Grant All the permissions to continue...",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 59, 5, 5),
              child: Image.asset("assets/image/permissions.png"),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.indigo)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Expanded(
                        child: Container(
                          color: Colors.black.withOpacity(0.8),
                          child: Center(
                              child: SpinKitRotatingCircle(
                                  color: Theme.of(context).primaryColor,
                                  size: 75)),
                        ),
                      );
                    },
                  );
                  requestPermissions();
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
