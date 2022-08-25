import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/models/subject/showdialog_widget.dart';
import 'package:multi_store/views/screens/customer_screens/customer_order_screen.dart';
import 'package:multi_store/views/screens/customer_screens/wishlist.dart';
import 'package:multi_store/views/screens/main_screens/cart_sceens.dart';
import 'package:multi_store/views/widgets/appbar_widget.dart';

import '../../widgets/header_lable_wiget.dart';
import '../../widgets/listtitle_wiget.dart';
import '../../widgets/yellow_divider_wiget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.grey,
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 140,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        child: const Text(
                          'Account',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      background: Container(
                        height: 230,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue,
                              Colors.grey,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25, left: 30),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/images/inapp/guest.jpg'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  'Guest'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(
                                    back: AppbarBackButton(),
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: const Center(
                                child: Text(
                                  'Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerOrderScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: const Center(
                                child: Text(
                                  'Orders',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WishlistScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: const Center(
                                child: Text(
                                  'Wishlist',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                          child: Image(
                              image:
                                  AssetImage('assets/images/inapp/logo.jpg')),
                        ),
                        const HeaderLabel(
                          lable: '  Account infor.  ',
                        ),
                        Container(
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: const [
                              RepeatedListTile(
                                title: 'Email Address',
                                subtitle: 'bonzed2001@gmail.com',
                                icon: Icons.email,
                              ),
                              YelloDivider(),
                              RepeatedListTile(
                                title: 'Phone',
                                subtitle: '+84373817499',
                                icon: Icons.phone,
                              ),
                              YelloDivider(),
                              RepeatedListTile(
                                title: 'Address',
                                subtitle: 'example: Ho Chi Minh - Viet Nam',
                                icon: Icons.location_pin,
                              ),
                            ],
                          ),
                        ),
                        const HeaderLabel(lable: '  Account Setting  '),
                        Container(
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              RepeatedListTile(
                                onPressed: () {},
                                title: 'Edit Profile',
                                icon: Icons.edit,
                              ),
                              const YelloDivider(),
                              RepeatedListTile(
                                onPressed: () {},
                                title: 'Change Password',
                                icon: Icons.lock,
                              ),
                              const YelloDivider(),
                              RepeatedListTile(
                                onPressed: () async {
                                  MyShowDialog.showMyDialog(
                                    context: context,
                                    content: 'Are your sure to log out?',
                                    title: 'Log out',
                                    tabNo: () => Navigator.pop(context),
                                    tabYes: () async {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                          context, '/welcome_screen');
                                    },
                                  );
                                },
                                title: 'Log Out',
                                icon: Icons.logout,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
