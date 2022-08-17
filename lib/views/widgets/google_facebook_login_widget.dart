import 'package:flutter/material.dart';

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget childs;

  const GoogleFacebookLogin({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.childs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(height: 50, width: 50, child: childs),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
