import 'package:flutter/material.dart';
import 'package:multi_store/views/screens/main_screens/categories_screen.dart';
import 'package:multi_store/views/screens/main_screens/dashboard_screen.dart';
import 'package:multi_store/views/screens/main_screens/home_page_screen.dart';
import 'package:multi_store/views/screens/main_screens/stores_screen.dart';
import 'package:multi_store/views/screens/main_screens/upload_product_screen.dart';

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
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
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
  }
}
