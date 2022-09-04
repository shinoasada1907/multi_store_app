import 'package:flutter/material.dart';
import 'package:multi_store/models/utilities/categ_list.dart';
import 'package:multi_store/views/widgets/categpry_header_widget.dart';
import 'package:multi_store/views/widgets/sliderbar_widget.dart';
import 'package:multi_store/views/widgets/subcatemodel_widget.dart';

class Womencategory extends StatelessWidget {
  const Womencategory({Key? key}) : super(key: key);

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
                  const CategoryHeader(header: 'Women'),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 68,
                      child: GridView.count(
                        mainAxisSpacing: 70,
                        crossAxisSpacing: 15,
                        crossAxisCount: 3,
                        children: List.generate(
                          women.length - 1,
                          (index) {
                            return SubCateModel(
                                mainCateName: 'Women',
                                subCatename: women[index + 1],
                                assetsName:
                                    'assets/images/women/women$index.jpg',
                                cateLabel: women[index + 1]);
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
            child: SliderBar(mainCateName: 'Women'),
          ),
        ],
      ),
    );
  }
}
