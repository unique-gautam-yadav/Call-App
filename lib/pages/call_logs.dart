import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'appbar.dart';
import 'package:intl/intl.dart';

import 'log_detail.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({Key key}) : super(key: key);

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  Iterable<CallLogEntry> entries;
  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  _getCallLogs() async {
    Iterable<CallLogEntry> entriess = await CallLog.get();
    for (var element in entriess) {}
    setState(() {
      entries = entriess;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body: (entries != null && entries.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  CallLogEntry log = entries.elementAt(index);
                  CallLogEntry prevLog =
                      entries.elementAt(index > 0 ? index - 1 : index);
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ShowDate(
                            log: log,
                            prevLog: prevLog,
                          ),
                          Card(
                              shape: const StadiumBorder(),
                              child: ListTile(
                                title: Text(log.name ?? "Unsaved"),
                                subtitle: Text(
                                    "${DateTime.fromMillisecondsSinceEpoch(log.timestamp).hour.toString().padLeft(2, "0")}:${DateTime.fromMillisecondsSinceEpoch(log.timestamp).minute.toString().padLeft(2, "0")}      ${log.number}"),
                                trailing: Type(log: log),
                              ))
                        ]),
                  );
                },
              ),
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



class _ShowDate extends StatelessWidget {
  const _ShowDate({
    Key key,
    @required this.log,
    this.prevLog,
  }) : super(key: key);

  final CallLogEntry log;
  final CallLogEntry prevLog;

  @override
  Widget build(BuildContext context) {
    int day = DateTime.fromMillisecondsSinceEpoch(log.timestamp).day;
    int prevDay = DateTime.fromMillisecondsSinceEpoch(prevLog.timestamp).day;
    int today = DateTime.now().day;
    String date = DateFormat('dd MMMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(log.timestamp));
    if (today == day) {
      return Column(
        children: const [const Text("Today"), SizedBox(height: 8)],
      );
    } else if (day != prevDay) {
      if (today - 1 == day) {
        return Column(
          children: const [const Text("Yesterday"), SizedBox(height: 8)],
        );
      } else {
        return Column(
          children: [Text(date), const SizedBox(height: 8)],
        );
      }
    } else {
      return const SizedBox(width: 0.0, height: 0.0);
    }
  }
}

class Type extends StatelessWidget {
  const Type({
    Key key,
    @required this.log,
  }) : super(key: key);

  final CallLogEntry log;

  @override
  Widget build(BuildContext context) {
    if (log.callType.name == "outgoing" ||
        log.callType.name == "wifiOutgoing") {
      return const Icon(Icons.call_made);
    } else if (log.callType.name == "incoming" ||
        log.callType.name == "wifiIncoming") {
      return const Icon(Icons.call_received);
    } else if (log.callType.name == "missed") {
      return const Icon(Icons.call_missed);
    } else if (log.callType.name == "rejected" ||
        log.callType.name == "blocked") {
      return const Icon(Icons.block_rounded);
    } else {
      return Text(log.callType.name);
    }
  }
}
