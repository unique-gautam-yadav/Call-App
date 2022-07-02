import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:slimmy_card/pages/contact_detail.dart';

import 'appbar.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Iterable<Contact> contacts;
  @override
  void initState() {
    super.initState();
    _askPermissions("/");
    getContact();
  }

  getContact() async {
    final Iterable<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

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
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          elevation: 0.25,
          centerTitle: true,
          title: MyAppBar(
              title: "Phone",
              icon1: Icons.add,
              icon2: Icons.search_outlined,
              icon3: Icons.more_horiz,
              width: 40),
          backgroundColor: Colors.white),
      body: contacts != null
          ? ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                if (contacts.isNotEmpty) {
                  Contact contact = contacts.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: const StadiumBorder(),
                      child: ListTile(
                        leading: Hero(
                          tag: Key("contactProfile${contact.identifier}"),
                          child: (contact.avatar != null &&
                                  contact.avatar.isNotEmpty)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar))
                              : CircleAvatar(
                                  child: contact.initials().isNotEmpty
                                      ? Text(contact.initials())
                                      : const Icon(Icons.person),
                                ),
                        ),
                        title: Text(contact.displayName),
                        subtitle: Text(contact.phones.last.value),
                        onTap: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 300));
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactDetail(contact: contact),
                              ));
                        },
                      ),
                    ),
                  );
                } else {
                  return SpinKitCircle(
                    color: Theme.of(context).primaryColor,
                  );
                }
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitSpinningLines(
                      color: Theme.of(context).primaryColor, size: 50),
                  const SizedBox(height: 8),
                  Text(
                    "Loading....",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
    );
  }
}
