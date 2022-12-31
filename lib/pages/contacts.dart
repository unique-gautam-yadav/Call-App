import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slimmy_card/pages/contact_info.dart';

import '../utils/components.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> contacts;
  @override
  void initState() {
    getContact();
    super.initState();
  }

  getContact() async {
    final List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          print(contacts.elementAt(167).phones.length);
          print(contacts.elementAt(168));
        },
      ),
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
                  return contact.phones.length > 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: const StadiumBorder(),
                            child: ListTile(
                              horizontalTitleGap: 20,
                              leading: Hero(
                                tag: Key("contactProfile${contact.identifier}"),
                                child: (contact.avatar != null &&
                                        contact.avatar.isNotEmpty)
                                    ? CircleAvatar(
                                        backgroundImage:
                                            MemoryImage(contact.avatar))
                                    : CircleAvatar(
                                        child: contact.initials().isNotEmpty
                                            ? Text(contact.initials())
                                            : const Icon(Icons.person),
                                      ),
                              ),
                              title: Text(contact.displayName),
                              subtitle: Text(contact.phones.last.value),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContactInfo(
                                            name: contact.displayName,
                                            phone:
                                                contact.phones.first.value)));
                              },
                            ),
                          ),
                        )
                      : const SizedBox();
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
