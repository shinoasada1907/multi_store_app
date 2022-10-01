import 'package:flutter/material.dart';

class RepeatedListTile extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final String subtitle;
  final IconData icon;
  const RepeatedListTile(
      {Key? key,
      this.onPressed,
      required this.title,
      this.subtitle = '',
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }
}
