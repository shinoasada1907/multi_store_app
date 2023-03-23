// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'package:multi_store/providers/cart_provider.dart';
import 'package:multi_store/screens/main_screens/cart_sceens.dart';
import 'package:multi_store/screens/minor_screen/visit_store.dart';
import 'package:multi_store/screens/minor_screen/full_screen_view.dart';
import 'package:multi_store/widgets/appbar_widget.dart';
import 'package:multi_store/widgets/snackbar.dart';
import 'package:multi_store/widgets/yellowbutton_widget.dart';
import 'package:badges/badges.dart' as badeges;

import '../../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailScreen({super.key, required this.proList});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: widget.proList['maincateg'])
      .where('subcateg', isEqualTo: widget.proList['subcateg'])
      .snapshots();

  late final Stream<QuerySnapshot> reviewProduct = FirebaseFirestore.instance
      .collection('products')
      .doc(widget.proList['productid'])
      .collection('reviews')
      .snapshots();

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late List<dynamic> imagelists = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    var onSale = widget.proList['discount'];
    var existingItemCart = context.read<Cart>().getItems.firstWhereOrNull(
        (product) => product.documentId == widget.proList['productid']);
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: scaffoldKey,
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
                            backgroundColor: Colors.lightBlue,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                            ),
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
                                  'USD ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  widget.proList['price'].toStringAsFixed(2),
                                  style: onSale != 0
                                      ? const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)
                                      : const TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                onSale != 0
                                    ? Text(
                                        ((1 - (onSale / 100)) *
                                                widget.proList['price'])
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : const Text(''),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                var existingItemWishlist = context
                                    .read<Wish>()
                                    .getWishItems
                                    .firstWhereOrNull((product) =>
                                        product.documentId ==
                                        widget.proList['productid']);
                                existingItemWishlist != null
                                    ? context.read<Wish>().removeThisItem(
                                        widget.proList['productid'])
                                    : context.read<Wish>().addWishItems(
                                          widget.proList['proname'],
                                          onSale != 0
                                              ? ((1 - (onSale / 100)) *
                                                  widget.proList['price'])
                                              : widget.proList['price'],
                                          1,
                                          widget.proList['instock'],
                                          widget.proList['proimages'],
                                          widget.proList['productid'],
                                          widget.proList['sid'],
                                        );
                              },
                              icon: context
                                          .watch<Wish>()
                                          .getWishItems
                                          .firstWhereOrNull((product) =>
                                              product.documentId ==
                                              widget.proList['productid']) !=
                                      null
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                            ),
                          ],
                        ),
                        widget.proList['instock'] == 0
                            ? const Text(
                                'this item is out of stock',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                ),
                              )
                            : Text(
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
                        Stack(
                          children: [
                            const Positioned(
                              right: 50,
                              top: 15,
                              child: Text('total'),
                            ),
                            ExpandableTheme(
                              data: const ExpandableThemeData(
                                iconColor: Colors.lightBlue,
                                iconSize: 30,
                              ),
                              child: reviews(reviewProduct),
                            ),
                          ],
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(
                                back: AppbarBackButton(),
                              ),
                            ),
                          );
                        },
                        icon: badeges.Badge(
                            showBadge: context.read<Cart>().getItems.isEmpty
                                ? false
                                : true,
                            padding: const EdgeInsets.all(4),
                            badgeColor: Colors.lightBlue,
                            badgeContent: Text(
                              context.watch<Cart>().getItems.length.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Icon(Icons.shopping_cart)),
                      ),
                    ],
                  ),
                  YellowButton(
                    name: existingItemCart != null
                        ? 'added to cart'
                        : 'ADD TO CART',
                    width: 0.55,
                    onPressed: () {
                      if (widget.proList['instock'] == 0) {
                        MessageHandler.showSnackSar(
                            scaffoldKey, 'this item is out of instock');
                      } else if (existingItemCart != null) {
                        MessageHandler.showSnackSar(
                            scaffoldKey, 'this item already in cart');
                      } else {
                        context.read<Cart>().addItems(
                              widget.proList['proname'],
                              onSale != 0
                                  ? ((1 - (onSale / 100)) *
                                      widget.proList['price'])
                                  : widget.proList['price'],
                              1,
                              widget.proList['instock'],
                              widget.proList['proimages'],
                              widget.proList['productid'],
                              widget.proList['sid'],
                            );
                      }
                    },
                  )
                ],
              ),
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

Widget reviews(var reviewProduct) {
  return ExpandablePanel(
    header: const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'Reviews',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.lightBlue,
        ),
      ),
    ),
    collapsed: SizedBox(
      height: 230,
      child: ReviewAll(reviewProduct),
    ),
    expanded: ReviewAll(reviewProduct),
  );
}

Widget ReviewAll(var reviewProduct) {
  return StreamBuilder<QuerySnapshot>(
    stream: reviewProduct,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      if (snapshot2.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot2.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot2.data!.docs.isEmpty) {
        return Center(
          child: Text(
            'This is not reviews',
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

      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot2.data!.docs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                snapshot2.data!.docs[index]['profileimage'],
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(snapshot2.data!.docs[index]['name']),
                Row(
                  children: [
                    Text(snapshot2.data!.docs[index]['rate'].toString()),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Text(
              snapshot2.data!.docs[index]['comment'],
              style: const TextStyle(fontSize: 15),
            ),
          );
        },
      );
    },
  );
}
