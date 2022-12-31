import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({
    Key key,
    @required this.title,
    @required this.icon1,
    @required this.icon2,
    @required this.icon3,
    @required this.width,
  }) : super(key: key);
  final String title;
  var icon1;
  var icon2;
  var icon3;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          children: [
            InkWell(
              onTap: null,
              child: SizedBox(
                width: width,
                child: Icon(
                  icon1,
                  color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: null,
              child: SizedBox(
                width: width,
                child: Icon(
                  icon2,
                  color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: null,
              child: SizedBox(
                width: width,
                child: Icon(
                  icon3,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}


class ShowDate extends StatelessWidget {
  const ShowDate({
    Key key,
    @required this.log,
    @required this.countt,
    @required this.prevLog,
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



String formatDuration(Duration duration) {
  String res = "";
  if (duration.inSeconds > 0) {
    res += ", ";
    if (duration.inHours > 0) {
      res += "${duration.inHours.toString()} hr ";
    }
    if (duration.inMinutes > 0) {
      res += "${duration.inMinutes - duration.inHours * 60} mins ";
    }
    if (duration.inSeconds > 0) {
      res +=
          "${duration.inSeconds - ((duration.inMinutes) - duration.inHours * 60) * 60} secs";
    }
  }
  return res;
}