import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';

class BalenceScreen extends StatelessWidget {
  const BalenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppbar(title: 'Balance'),
        leading: const AppbarBackButton(),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
