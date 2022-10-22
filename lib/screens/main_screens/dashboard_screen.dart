import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/screens/dashborard_components/balance_screen.dart';
import 'package:multi_store/screens/dashborard_components/edit_profile_screen.dart';
import 'package:multi_store/screens/dashborard_components/manage_product_screen.dart';
import 'package:multi_store/screens/dashborard_components/order_sceen.dart';
import 'package:multi_store/screens/dashborard_components/static_screen.dart';
import 'package:multi_store/screens/main_screens/visit_store.dart';
import 'package:multi_store/widgets/appbar_widget.dart';

import '../../widgets/showdialog_widget.dart';

List<Widget> pages = [
  VisitStoreScreen(sId: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrderScreen(),
  const EditProfileScreen(),
  const ManageProductScreen(),
  const BalenceScreen(),
  const StaticScreen(),
];

List<String> labels = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'static',
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.money,
  Icons.show_chart,
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
        centerTitle: true,
        title: const TitleAppbar(title: 'Dashboard'),
        actions: [
          IconButton(
            onPressed: () async {
              MyShowDialog.showMyDialog(
                context: context,
                content: 'Are your sure to log out?',
                title: 'Log out',
                tabNo: () => Navigator.pop(context),
                tabYes: () async {
                  await FirebaseAuth.instance.signOut();
                  await Future.delayed(const Duration(microseconds: 100))
                      .whenComplete(() {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/welcome_screen');
                  });
                },
              );
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade400,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pages[index],
                    ),
                  );
                },
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(icons[index]),
                        color: Colors.lightBlue,
                        iconSize: 50,
                      ),
                      Text(
                        labels[index].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme',
                          color: Colors.lightBlue,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
