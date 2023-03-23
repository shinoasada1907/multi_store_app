import 'package:badges/badges.dart' as badeges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/screens/main_screens/categories_screen.dart';
import 'package:multi_store/screens/main_screens/dashboard_screen.dart';
import 'package:multi_store/screens/main_screens/home_page_screen.dart';
import 'package:multi_store/screens/main_screens/stores_screen.dart';
import 'package:multi_store/screens/main_screens/upload_product_screen.dart';

class SupplierHomePage extends StatefulWidget {
  const SupplierHomePage({Key? key}) : super(key: key);

  @override
  State<SupplierHomePage> createState() => _SupplierHomePageState();
}

class _SupplierHomePageState extends State<SupplierHomePage> {
  int _selecteditem = 0;

  final List _screens = const [
    HomePageScreen(),
    CategoryScreen(),
    StoreScreen(),
    DashboardScreen(),
    UploadProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('deliverystatus', isEqualTo: 'preparing')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: _screens[_selecteditem],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            selectedItemColor: Colors.lightBlue,
            unselectedItemColor: Colors.black,
            currentIndex: _selecteditem,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: 'Stores',
              ),
              BottomNavigationBarItem(
                icon: badeges.Badge(
                  showBadge: snapshot.data!.docs.isEmpty ? false : true,
                  padding: const EdgeInsets.all(4),
                  badgeColor: Colors.red,
                  badgeContent: Text(
                    snapshot.data!.docs.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Icon(Icons.dashboard),
                ),
                label: 'Dashboard',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.upload),
                label: 'Upload',
              ),
            ],
            onTap: (index) {
              setState(() {
                _selecteditem = index;
              });
            },
          ),
        );
      },
    );
  }
}
