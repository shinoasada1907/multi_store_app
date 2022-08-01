import 'package:flutter/material.dart';
import 'package:multi_store/models/subject/listitem.dart';
import 'package:multi_store/views/widgets/search_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const SearchWidget(),
      ),
      body: Stack(
        children: [
          Positioned(
            child: sideNavigator(size),
            bottom: 0,
            left: 0,
          ),
          Positioned(
            child: cateView(size),
            bottom: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.9,
      width: size.width * 0.2,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              for (var element in items) {
                //duyệt lại các item về lại trạng thái ban đầu
                element.iselected = false;
              }
              setState(() {
                //thay đổi trạng thái của item khi được chọn
                items[index].iselected = true;
              });
            },
            child: Container(
              color: items[index].iselected == true
                  ? Colors.white
                  : Colors.grey.shade300,
              height: 100,
              child: Center(
                child: Text(
                  items[index].label.toString(),
                  style: const TextStyle(color: Colors.black),
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
      height: size.height * 0.9,
      width: size.width * 0.8,
      color: Colors.white,
    );
  }
}
