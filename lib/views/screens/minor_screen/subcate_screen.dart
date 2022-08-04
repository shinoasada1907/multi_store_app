import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/appbar_widget.dart';

class SubCateScreen extends StatelessWidget {
  final String maincateName;
  final String subcateName;
  const SubCateScreen(
      {Key? key, required this.maincateName, required this.subcateName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppbarBackButton(),
        title: TitleAppbar(title: subcateName),
      ),
      body: Center(
        child: Text(maincateName),
      ),
    );
  }
}
