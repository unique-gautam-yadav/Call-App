import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class KeyPad extends StatelessWidget {
  const KeyPad({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DialPad(
                dialButtonColor: Theme.of(context).primaryColor,
                enableDtmf: true,
                outputMask: "+91-00000 00000",
                backspaceButtonIconColor: Colors.red,
                makeCall: (number) {
                  number = "+91$number";
                  FlutterPhoneDirectCaller.callNumber(number);
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onDoubleTap: () => FlutterPhoneDirectCaller.callNumber("112"),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Double tap to call emergency number."))),
                  child: Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.red.shade900,
                      ),
                      child: const Center(
                        child: Text("Emergency Call",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 40)
          ],
        ));
  }
}
