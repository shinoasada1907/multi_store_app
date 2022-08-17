import 'package:flutter/material.dart';

import '../screens/minor_screen/subcate_screen.dart';

class SubCateModel extends StatelessWidget {
  final String mainCateName;
  final String subCatename;
  final String assetsName;
  final String cateLabel;
  const SubCateModel({
    Key? key,
    required this.mainCateName,
    required this.subCatename,
    required this.assetsName,
    required this.cateLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCateScreen(
              maincateName: mainCateName,
              subcateName: subCatename,
            ),
          ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Image(image: AssetImage(assetsName)),
            ),
            Text(
              cateLabel,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
