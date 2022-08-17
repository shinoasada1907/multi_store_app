import 'package:flutter/material.dart';

class HeaderLabel extends StatelessWidget {
  final String lable;
  const HeaderLabel({
    Key? key,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 40,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            lable,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 40,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
