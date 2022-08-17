import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppbar(title: 'Edit Profile'),
        leading: const AppbarBackButton(),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
