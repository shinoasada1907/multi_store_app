import 'package:flutter/material.dart';
import 'package:multi_store/providers/wishlist_provider.dart';
import 'package:multi_store/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../../models/wish_model.dart';
import '../../widgets/showdialog_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: const AppbarBackButton(),
            title: const TitleAppbar(
              title: 'Wishlist',
            ),
            actions: [
              context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyShowDialog.showMyDialog(
                          context: context,
                          title: 'Clear Wishlist',
                          content: 'Are you sure to clear Wishlist?',
                          tabNo: () {
                            Navigator.pop(context);
                          },
                          tabYes: () {
                            context.read<Wish>().clearWishlist();
                            Navigator.pop(context);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
            ],
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              //context.watch<Cart>() t????ng t??? c??i d?????i nh??ng ng???n g???n h??n d??ng t??? watch ????? bi???u th??? cho vi???c listen = true v?? c?? th??? cho ph??p ?????c
              //Provider.of<Cart>(context, listen: true).getItems.isNotEmpty
              //D??ng ????? cho provider nghe th???y c?? s??? thay ?????i v?? ?????c n?? ra m??n h??nh thay ?????i ????
              //listen = false: ch??? ?????c kh??ng nghe thay s??? thay d???i
              //listen = false: cho ph??p l???ng nghe s??? thay ?????i v?? ?????c
              ? const WishItem()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Your Wishlist is empty!',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}

class WishItem extends StatelessWidget {
  const WishItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, list, child) {
        return ListView.builder(
          itemCount: list.count,
          itemBuilder: (context, index) {
            final product = list.getWishItems[index];
            return WishlistModel(product: product);
          },
        );
      },
    );
  }
}
