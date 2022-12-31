import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:slimy_card/slimy_card.dart';

class LogDetail extends StatelessWidget {
  const LogDetail({
    Key key,
    @required this.log,
  }) : super(key: key);

  final CallLogEntry log;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            SlimyCard(
              topCardWidget: _topCard(log: log),
              bottomCardWidget: _bottomCard(
                log: log,
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
    @required this.log,
  }) : super(key: key);

  final CallLogEntry log;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          log.name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          log.formattedNumber,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        )
      ],
    );
  }
}

class _bottomCard extends StatelessWidget {
  const _bottomCard({Key key, @required this.log}) : super(key: key);
  final CallLogEntry log;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
                    "${log.duration}  :  ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
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
                      String number = log.formattedNumber;
                      await FlutterPhoneDirectCaller.callNumber(number);
                    },
                    icon: const Icon(Icons.call, color: Colors.black87)),
              )
            ],
          )
        ],
      ),
    );
  }
}
