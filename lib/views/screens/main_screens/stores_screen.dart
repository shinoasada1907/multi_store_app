import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/appbar_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const TitleAppbar(
          title: 'Stores',
        ),
      ),
    );
  }
}
