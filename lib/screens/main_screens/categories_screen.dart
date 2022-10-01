import 'package:flutter/material.dart';
import 'package:multi_store/models/subject/listitem.dart';
import 'package:multi_store/screens/categories_screens/accessory_category.dart';
import 'package:multi_store/screens/categories_screens/bag_category.dart';
import 'package:multi_store/screens/categories_screens/beauty_category.dart';
import 'package:multi_store/screens/categories_screens/electronic_category.dart';
import 'package:multi_store/screens/categories_screens/homeandgarden_category.dart';
import 'package:multi_store/screens/categories_screens/kid_category.dart';
import 'package:multi_store/screens/categories_screens/men_category.dart';
import 'package:multi_store/screens/categories_screens/shoes_category.dart';
import 'package:multi_store/screens/categories_screens/women_category.dart';
import 'package:multi_store/widgets/search_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    for (var element in items) {
      element.iselected = false;
    }
    setState(() {
      items[0].iselected = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const SearchWidget(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: sideNavigator(size),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: cateView(size),
          ),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            child: Container(
              color: items[index].iselected == true
                  ? Colors.white
                  : Colors.grey.shade300,
              height: 100,
              child: Center(
                child: Text(
                  items[index].label.toString(),
                  style: TextStyle(
                    color: items[index].iselected == true
                        ? Colors.lightBlue
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cateView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          for (var element in items) {
            element.iselected = false;
          }
          setState(() {
            items[value].iselected = true;
          });
        },
        children: const [
          MenCategory(),
          Womencategory(),
          ShoesCategory(),
          BagCategory(),
          ElectronicCategory(),
          Accessorycategory(),
          HomeAndGardencategory(),
          Kidcategory(),
          BeautyCategory(),
        ],
      ),
    );
  }
}
