// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slimmy_card/pages/home.dart';

class GetPermission extends StatefulWidget {
  const GetPermission({Key key}) : super(key: key);

  @override
  State<GetPermission> createState() => _GetPermissionState();
}

class _GetPermissionState extends State<GetPermission> {
  @override
  void initState() {
    var dd = Permission.contacts.status;
    // ignore: unrelated_type_equality_checks
    if (dd.isGranted != null && dd.isGranted == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> _getPermission() {
    //   print("object");
    // }

    Future<PermissionStatus> _getContactPermission() async {
      PermissionStatus permission = await Permission.contacts.status;
      if (permission != PermissionStatus.granted &&
          permission != PermissionStatus.permanentlyDenied) {
        PermissionStatus permissionStatus = await Permission.contacts.request();
        return permissionStatus;
      } else {
        return permission;
      }
    }

    void _handleInvalidPermissions(PermissionStatus permissionStatus) {
      if (permissionStatus == PermissionStatus.denied) {
        const snackBar =
            SnackBar(content: Text('Access to contact data denied'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
        const snackBar =
            SnackBar(content: Text('Contact data not available on device'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    Future<void> _askPermissions(String routeName) async {
      PermissionStatus permissionStatus = await _getContactPermission();
      if (permissionStatus != PermissionStatus.granted) {
        _handleInvalidPermissions(permissionStatus);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      }
    }

    return Scaffold(
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
                  _askPermissions("/");
                },
                child: const Text("Continue"))
          ],
        ),
      ),
    );
  }
}
