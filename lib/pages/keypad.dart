import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  const KeyPad({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const Center(
        child: Icon(
          Icons.keyboard,
          size: 100,
        ),
      ),
    );
  }
}
