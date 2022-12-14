import 'package:flutter/material.dart';
import 'package:multi_store/models/utilities/categ_list.dart';
import 'package:multi_store/widgets/categpry_header_widget.dart';
import 'package:multi_store/widgets/sliderbar_widget.dart';
import 'package:multi_store/widgets/subcatemodel_widget.dart';

class HomeAndGardencategory extends StatelessWidget {
  const HomeAndGardencategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryHeader(header: 'Home & Garden'),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 68,
                      child: GridView.count(
                        mainAxisSpacing: 70,
                        crossAxisSpacing: 15,
                        crossAxisCount: 3,
                        children: List.generate(
                          homeandgarden.length - 1,
                          (index) {
                            return SubCateModel(
                                mainCateName: 'homeandgarden',
                                subCatename: homeandgarden[index + 1],
                                assetsName:
                                    'assets/images/homegarden/home$index.jpg',
                                cateLabel: homeandgarden[index + 1]);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: SliderBar(mainCateName: 'Home & Garden'),
          ),
        ],
      ),
    );
  }
}
