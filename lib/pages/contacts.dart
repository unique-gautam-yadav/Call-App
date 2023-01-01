import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slimmy_card/pages/add_contact.dart';
import 'package:slimmy_card/pages/contact_info.dart';
import 'package:slimmy_card/pages/search_contact.dart';

import '../utils/components.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Widget> items;
  @override
  void initState() {
    items = <Widget>[];
    getContact();
    super.initState();
  }

  getContact() async {
    final List<Contact> c = await ContactsService.getContacts();
    for (int i = 0; i < c.length; i++) {
      Widget one = ContactWidget(contact: c.elementAt(i));
      setState(() {
        items.add(one);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.25,
        centerTitle: true,
        title: const Text("Contacts"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddContact(),
                    ));
              },
              icon: const Icon(CupertinoIcons.add)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchContact(),
                    ));
              },
              icon: const Icon(CupertinoIcons.search)),
        ],
      ),
      body: items.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
              children: items,
            ))
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

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const StadiumBorder(),
        child: ListTile(
          horizontalTitleGap: 20,
          leading: (contact.avatar != null && contact.avatar.isNotEmpty)
              ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar))
              : CircleAvatar(
                  child: contact.initials().isNotEmpty
                      ? Text(contact.initials())
                      : const Icon(Icons.person),
                ),
          title: Text(contact.displayName),
          subtitle: Text(contact.phones.last.value),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactInfo(
                        name: contact.displayName,
                        phone: contact.phones.first.value)));
          },
        ),
      ),
    );
  }
}
