import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final String name;
  final Function() onPressed;
  final double width;
  const DeleteButton(
      {Key? key,
      required this.name,
      required this.width,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
