import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/appbar_widget.dart';

class CustomerOrderScreen extends StatelessWidget {
  const CustomerOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleAppbar(title: 'Customer Order'),
        leading: const AppbarBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
