import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:slimmy_card/pages/call_logs.dart';
import 'package:intl/intl.dart';
import 'package:slimmy_card/utils/components.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key key, this.phone, this.name}) : super(key: key);

  final String phone;
  final String name;

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  List<Contact> contacts;
  List<Widget> logItems;

  fetchContact() async {
    List<Contact> lCon = await ContactsService.getContacts(query: widget.name);
    if (lCon.isEmpty) {
      lCon[1] = Contact(displayName: "Unsaved", avatar: null);
    }
    setState(() {
      contacts = lCon;
    });
    print("contact =  ${contacts.length}");
    //
  }

  fetchLog() async {
    Iterable<CallLogEntry> lLogs = await CallLog.query(number: widget.phone);
    for (int i = 0; i < lLogs.length; i++) {
      Widget one = LogItem(log: lLogs.elementAt(i));
      setState(() {
        logItems.add(one);
      });
    }
    print("Logs ${logItems.length}");
  }

  @override
  void initState() {
    logItems = <Widget>[];
    fetchContact();
    fetchLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(40)),
                      child: Column(
                        children: [
                          const SizedBox(height: 65),
                          Text(
                            contacts != null
                                ? contacts.elementAt(0).displayName ??
                                    "Not found"
                                : "Unsaved",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.phone,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green.shade900,
                                    borderRadius: BorderRadius.circular(500)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.call,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    borderRadius: BorderRadius.circular(500)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.message,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent.shade700,
                                    borderRadius: BorderRadius.circular(500)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.whatsapp,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: contacts != null
                              ? (contacts.elementAt(0).avatar != null &&
                                      contacts.elementAt(0).avatar.isNotEmpty)
                                  ? CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      backgroundImage: MemoryImage(
                                          contacts.elementAt(0).avatar))
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: contacts
                                              .elementAt(0)
                                              .initials()
                                              .isNotEmpty
                                          ? Center(
                                              child: Text(
                                              contacts.elementAt(0).initials(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  .copyWith(
                                                      color: Colors.white),
                                            ))
                                          : const Center(
                                              child: Icon(Icons.person,
                                                  color: Colors.white,
                                                  size: 75)))
                              : Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Center(
                                      child: Icon(Icons.person,
                                          color: Colors.white, size: 75)))))
                ],
              ),
            ),
            const Divider(),
            Column(children: logItems ?? const [SizedBox()])
          ],
        ),
      ),
    );
  }
}

class LogItem extends StatelessWidget {
  const LogItem({Key key, this.log}) : super(key: key);

  final CallLogEntry log;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(log.timestamp);
    Duration dur = Duration(seconds: log.duration);
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(bottom: .3),
        child: Container(
          color: Colors.white,
          child: ListTile(
            onLongPress: () {},
            onTap: () {},
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(500)),
                child: LogTypeIcon(log: log)),
            title: Text(DateFormat("EEE, dd MMM yy").format(time).toString()),
            subtitle: Text("${log.callType.name} call${formatDuration(dur)}"),
            trailing: Text(DateFormat("HH:mm").format(time).toString()),
          ),
        ),
      ),
    );
  }
}
