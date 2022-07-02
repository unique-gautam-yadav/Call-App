// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key key, @required this.contact})
      : assert(contact != null),
        super(key: key);
  final Contact contact;

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            SlimyCard(
              topCardWidget: _topCard(contact: widget.contact),
              bottomCardWidget: _bottomCard(
                contact: widget.contact,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _topCard extends StatelessWidget {
  const _topCard({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    _makeCall(String phoneNumber) async {
      String number = phoneNumber;
      await FlutterPhoneDirectCaller.callNumber(number);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 85,
            width: 85,
            child: Hero(
              tag: Key("contactProfile${contact.identifier}"),
              child: (contact.avatar != null && contact.avatar.isNotEmpty)
                  ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar))
                  : CircleAvatar(
                      child: contact.initials().isNotEmpty
                          ? Text(contact.initials())
                          : const Icon(Icons.person),
                    ),
            )),
        const SizedBox(height: 6),
        Text(
          contact.displayName,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          contact.givenName,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        )
      ],
    );
  }
}

class _bottomCard extends StatelessWidget {
  const _bottomCard({Key key, @required this.contact}) : super(key: key);
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: contact.phones.length,
        itemBuilder: (context, index) {
          Item phone = contact.phones[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "${phone.label}  :  ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        phone.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade400),
                    child: IconButton(
                        onPressed: () async {
                          String number = phone.value;
                          print(number);
                          await FlutterPhoneDirectCaller.callNumber(number);
                        },
                        icon: const Icon(Icons.call, color: Colors.black87)),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
