import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:slimmy_card/pages/contact_info.dart';

import '../utils/components.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({Key key}) : super(key: key);

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  List<Widget> items;
  int dateTo = DateTime.now().millisecondsSinceEpoch;
  int dateFrom =
      DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch;

  @override
  void initState() {
    getLogsFirstTime();
    items = <Widget>[];

    super.initState();
  }

  getLogsFirstTime() async {
    Iterable<CallLogEntry> ent =
        await CallLog.query(dateTo: dateTo, dateFrom: dateFrom);
    for (int i = 0; i < ent.length; i++) {
      Widget one;
      if (i == 0) {
        one = LogItem(
          index: i,
          prevLog: ent.elementAt(i),
          log: ent.elementAt(i),
        );
      } else {
        one = LogItem(
          index: i,
          prevLog: ent.elementAt(i - 1),
          log: ent.elementAt(i),
        );
      }
      setState(() {
        items.add(one);
      });
    }
  }

  getLogs() async {
    dateFrom = dateTo;
    dateTo = DateTime.fromMillisecondsSinceEpoch(dateFrom)
        .subtract(const Duration(days: 7))
        .millisecondsSinceEpoch;
    Iterable<CallLogEntry> ent =
        await CallLog.query(dateFrom: dateFrom, dateTo: dateTo);
    for (int i = 0; i < ent.length; i++) {
      Widget one;
      if (i == 0) {
        one = LogItem(
          index: i,
          prevLog: ent.elementAt(i),
          log: ent.elementAt(i),
        );
      } else {
        one = LogItem(
          index: i,
          prevLog: ent.elementAt(i - 1),
          log: ent.elementAt(i),
        );
      }
      setState(() {
        items.add(one);
      });
    }
    print(ent.length);
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: MyAppBar(
                title: "Phone",
                icon1: Icons.filter_alt_outlined,
                icon2: Icons.search_outlined,
                icon3: Icons.more_horiz,
                width: 40),
            backgroundColor: Colors.white),
        body: GestureDetector(
          onPanDown: (details) {
            print("SDlkfjj");
          },
          child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: items != null && items.isNotEmpty
                    ? items
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SpinKitSpinningLines(
                                color: Theme.of(context).primaryColor,
                                size: 50),
                            const SizedBox(height: 8),
                            Text(
                              "Loading....",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      ),
              )),
        ));
  }
}

class LogTypeIcon extends StatelessWidget {
  const LogTypeIcon({
    Key key,
    @required this.log,
  }) : super(key: key);

  final CallLogEntry log;

  @override
  Widget build(BuildContext context) {
    if (log.callType.name == "outgoing" ||
        log.callType.name == "wifiOutgoing") {
      return Icon(
        Icons.call_made,
        color: Colors.green[800],
      );
    } else if (log.callType.name == "incoming" ||
        log.callType.name == "wifiIncoming") {
      return const Icon(
        Icons.call_received,
        color: Colors.blueAccent,
      );
    } else if (log.callType.name == "missed") {
      return Icon(
        Icons.call_missed,
        color: Colors.red[900],
      );
    } else if (log.callType.name == "rejected" ||
        log.callType.name == "blocked") {
      return Icon(
        Icons.block_rounded,
        color: Colors.red[900],
      );
    } else {
      return Text(log.callType.name);
    }
  }
}

class LogItem extends StatelessWidget {
  const LogItem({Key key, this.index, this.log, this.prevLog})
      : super(key: key);

  final int index;
  final CallLogEntry log;
  final CallLogEntry prevLog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ShowDate(
          countt: index,
          log: log,
          prevLog: prevLog,
        ),
        Card(
            shape: const StadiumBorder(),
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactInfo(
                          phone: log.number, name: log.name ?? "unsaved"))),
              title: Text(log.name ?? log.formattedNumber),
              subtitle: Text(
                  "${DateTime.fromMillisecondsSinceEpoch(log.timestamp).hour.toString().padLeft(2, "0")}:${DateTime.fromMillisecondsSinceEpoch(log.timestamp).minute.toString().padLeft(2, "0")}          ${log.name != null ? log.formattedNumber ?? log.number : ""}"),
              trailing: LogTypeIcon(log: log),
            ))
      ]),
    );
  }
}
