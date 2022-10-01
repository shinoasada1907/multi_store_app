import 'package:flutter/material.dart';

class TitleAppbar extends StatelessWidget {
  final String title;
  const TitleAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 26,
        letterSpacing: 1.5,
        fontFamily: 'Acme',
      ),
    );
  }
}

class AppbarBackButton extends StatelessWidget {
  const AppbarBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}

class LightBlueBackButton extends StatelessWidget {
  const LightBlueBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.lightBlue,
      ),
    );
  }
}
