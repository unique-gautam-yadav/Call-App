import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slimmy_card/pages/log_detail.dart';
import 'package:intl/intl.dart';

import '../utils/components.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({Key key}) : super(key: key);

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  List<Widget> items;
  @override
  void initState() {
    _getCallLogs();
    items = <Widget>[];

    super.initState();
  }

  _getCallLogs() async {
    Iterable<CallLogEntry> ent = await CallLog.get();
    for (int i = 0; i < 30; i++) {
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

      items.add(one);
    }
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
        body: SingleChildScrollView(
          child: Column(
            children: items,
          ),
        ));
  }
}

class _ShowDate extends StatelessWidget {
  const _ShowDate({
    Key key,
    @required this.log,
    @required this.countt,
    this.prevLog,
  }) : super(key: key);

  final CallLogEntry log;
  final int countt;
  final CallLogEntry prevLog;

  @override
  Widget build(BuildContext context) {
    int day = DateTime.fromMillisecondsSinceEpoch(log.timestamp).day;
    int prevDay = DateTime.fromMillisecondsSinceEpoch(prevLog.timestamp).day;
    int today = DateTime.now().day;
    String date = DateFormat('dd MMMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(log.timestamp));
    if (day == prevDay && countt == 0) {
      return Column(
        children: const [Text("Today"), SizedBox(height: 8)],
      );
    } else if (day != prevDay) {
      if (today - 1 == day) {
        return Column(
          children: const [Text("Yesterday"), SizedBox(height: 8)],
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
        _ShowDate(
          countt: index,
          log: log,
          prevLog: prevLog,
        ),
        Card(
            shape: const StadiumBorder(),
            child: ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogDetail(log: log))),
              title: Text(log.name ?? log.formattedNumber),
              subtitle: Text(
                  "${DateTime.fromMillisecondsSinceEpoch(log.timestamp).hour.toString().padLeft(2, "0")}:${DateTime.fromMillisecondsSinceEpoch(log.timestamp).minute.toString().padLeft(2, "0")}          ${log.name != null ? log.formattedNumber ?? log.number : ""}"),
              trailing: Type(log: log),
            ))
      ]),
    );
  }
}
