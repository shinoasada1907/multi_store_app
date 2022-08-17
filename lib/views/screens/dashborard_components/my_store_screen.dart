import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/appbar_widget.dart';

class MyStoreScreen extends StatelessWidget {
  const MyStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppbar(title: 'My Store'),
        leading: const AppbarBackButton(),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
