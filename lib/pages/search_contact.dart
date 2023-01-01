import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slimmy_card/pages/contacts.dart';

class SearchContact extends StatefulWidget {
  const SearchContact({Key key}) : super(key: key);

  @override
  State<SearchContact> createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContact> {
  TextEditingController controller = TextEditingController();

  List<Widget> items;

  bool crossIcon = false;

  searchCont(String val) async {
    items.clear();
    List<Contact> c = await ContactsService.getContacts(query: val);
    for (int i = 0; i < c.length; i++) {
      Widget one = ContactWidget(contact: c.elementAt(i));
      setState(() {
        items.add(one);
      });
    }
  }

  @override
  void initState() {
    items = <Widget>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: TextField(
          controller: controller,
          onChanged: (value) {
            if (value.isNotEmpty) {
              crossIcon = true;
              searchCont(value);
            } else {
              crossIcon = false;
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: Icon(controller.text.isEmpty || !crossIcon
                  ? CupertinoIcons.search
                  : CupertinoIcons.xmark))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: items,
      )),
    );
  }
}
