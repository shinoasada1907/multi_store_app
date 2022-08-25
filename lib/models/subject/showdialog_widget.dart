import 'package:flutter/material.dart';

class MyShowDialog {
  static void showMyDialog({
    required BuildContext context,
    required String title,
    required String content,
    required Function() tabNo,
    required Function() tabYes,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: tabNo,
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: tabYes,
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ));
  }
}
