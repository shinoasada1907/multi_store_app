import 'package:flutter/material.dart';
import 'package:multi_store/screens/galleries/accessory_gallery.dart';
import 'package:multi_store/screens/galleries/bag_gallery.dart';
import 'package:multi_store/screens/galleries/beauty_gallery.dart';
import 'package:multi_store/screens/galleries/electronic_galllery.dart';
import 'package:multi_store/screens/galleries/home_and_garden_gallery.dart';
import 'package:multi_store/screens/galleries/kid_gallery.dart';
import 'package:multi_store/screens/galleries/men_gallery.dart';
import 'package:multi_store/screens/galleries/shoes_gallery.dart';
import 'package:multi_store/screens/galleries/women_gallery.dart';
import 'package:multi_store/widgets/search_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const SearchWidget(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorWeight: 5,
            tabs: [
              RepeatedTab(
                label: 'Men',
              ),
              RepeatedTab(
                label: 'Women',
              ),
              RepeatedTab(
                label: 'Shoes',
              ),
              RepeatedTab(
                label: 'Bags',
              ),
              RepeatedTab(
                label: 'Electronics',
              ),
              RepeatedTab(
                label: 'Accessories',
              ),
              RepeatedTab(
                label: 'Home & Garden',
              ),
              RepeatedTab(
                label: 'Kids',
              ),
              RepeatedTab(
                label: 'Beauty',
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          MenGalleryScreen(),
          WomenGalleryScreen(),
          ShoesGalleryScreen(),
          BagGalleryScreen(),
          MenElectronicGalleryScreen(),
          AccessoriesGalleryScreen(),
          HomeAndGardenGalleryScreen(),
          KidsGalleryScreen(),
          BeautyGalleryScreen(),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
