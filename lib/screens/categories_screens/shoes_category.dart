import 'package:flutter/material.dart';
import 'package:multi_store/models/utilities/categ_list.dart';
import 'package:multi_store/widgets/categpry_header_widget.dart';
import 'package:multi_store/widgets/sliderbar_widget.dart';
import 'package:multi_store/widgets/subcatemodel_widget.dart';

class ShoesCategory extends StatelessWidget {
  const ShoesCategory({Key? key}) : super(key: key);

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
                  const CategoryHeader(header: 'Shoes'),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 68,
                      child: GridView.count(
                        mainAxisSpacing: 70,
                        crossAxisSpacing: 15,
                        crossAxisCount: 3,
                        children: List.generate(
                          shoes.length - 1,
                          (index) {
                            return SubCateModel(
                                mainCateName: 'shoes',
                                subCatename: shoes[index + 1],
                                assetsName:
                                    'assets/images/shoes/shoes$index.jpg',
                                cateLabel: shoes[index + 1]);
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
            child: SliderBar(mainCateName: 'Shoes'),
          ),
        ],
      ),
    );
  }
}
