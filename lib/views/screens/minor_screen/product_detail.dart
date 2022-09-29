// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store/views/screens/main_screens/visit_store.dart';
import 'package:multi_store/views/screens/minor_screen/full_screen_view.dart';
import 'package:multi_store/views/widgets/yellowbutton_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailScreen({super.key, required this.proList});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late List<dynamic> imagelists = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.proList['maincateg'])
        .where('subcateg', isEqualTo: widget.proList['subcateg'])
        .snapshots();
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenView(
                        imagelist: imagelists,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Swiper(
                          pagination: const SwiperPagination(
                              builder: SwiperPagination.dots),
                          itemBuilder: (context, index) {
                            return Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                imagelists[index],
                              ),
                            );
                          },
                          itemCount: imagelists.length,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 15,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.lightBlue,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 15,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.proList['proname'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                ' USD ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.proList['price'].toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        (widget.proList['instock'].toString()) +
                            (' pieces available in stock'),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const ProductDetailHeader(
                        header: '   Item Description   ',
                      ),
                      Text(
                        widget.proList['prodesc'],
                        textScaleFactor: 1.1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                      const ProductDetailHeader(
                        header: '   Similar Items   ',
                      ),
                      SizedBox(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _productStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'This is not product',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey.shade600,
                                    fontFamily: 'Acme',
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              child: StaggeredGridView.countBuilder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                crossAxisCount: 2,
                                itemBuilder: (context, index) {
                                  return ProductModel(
                                    product: snapshot.data!.docs[index],
                                  );
                                },
                                staggeredTileBuilder: (context) =>
                                    const StaggeredTile.fit(1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisitStoreScreen(
                              sId: widget.proList['sid'],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.store),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
                YellowButton(
                  name: 'ADD TO CART',
                  width: 0.55,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailHeader extends StatelessWidget {
  final String header;
  const ProductDetailHeader({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Divider(
              color: Colors.lightBlue.shade600,
              thickness: 1,
            ),
          ),
          Text(
            header,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.lightBlue.shade600,
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Divider(
              color: Colors.lightBlue.shade600,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
