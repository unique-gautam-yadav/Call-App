// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

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
