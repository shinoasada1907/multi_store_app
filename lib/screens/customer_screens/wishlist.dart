import 'package:flutter/material.dart';
import 'package:multi_store/widgets/appbar_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleAppbar(title: 'Wishlist'),
        leading: const AppbarBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
