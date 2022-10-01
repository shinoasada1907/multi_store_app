import 'package:flutter/material.dart';

class YelloDivider extends StatelessWidget {
  const YelloDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.lightBlue,
        thickness: 1,
      ),
    );
  }
}
