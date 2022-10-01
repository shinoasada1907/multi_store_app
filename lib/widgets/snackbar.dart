import 'package:flutter/material.dart';

class MessageHandler {
  static void showSnackSar(var scaffoldKey, String mess) {
    scaffoldKey.currentState!.hideCurrentSnackBar();
    scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.lightBlue,
        content: Text(
          mess,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
