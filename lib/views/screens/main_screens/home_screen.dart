import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/views/screens/main_screens/cart_sceens.dart';
import 'package:multi_store/views/screens/main_screens/categories_screen.dart';
import 'package:multi_store/views/screens/main_screens/home_page_screen.dart';
import 'package:multi_store/views/screens/main_screens/profile.dart';
import 'package:multi_store/views/screens/main_screens/stores_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selecteditem = 0;

  final List _screens = [
    const HomePageScreen(),
    const CategoryScreen(),
    const StoreScreen(),
    const CartScreen(),
    ProfileScreen(
      documentId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selecteditem],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        currentIndex: _selecteditem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selecteditem = index;
          });
        },
      ),
    );
  }
}
