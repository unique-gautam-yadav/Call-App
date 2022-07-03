import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';

class LogDetail extends StatelessWidget {
  const LogDetail({
    Key key,
    @required this.log,
  }) : super(key: key);

  final CallLogEntry log;

  @override
  Widget build(BuildContext context) {
    return Text(log.number);
  }
}
