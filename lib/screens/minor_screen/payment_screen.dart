// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store/providers/cart_provider.dart';
import 'package:multi_store/widgets/appbar_widget.dart';
import 'package:multi_store/widgets/yellowbutton_widget.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedValue = 1;
  late String orderId;
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customers');

  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(
        max: 100, msg: 'Please wait ...', progressBgColor: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = context.watch<Cart>().totalPrice;
    double totalPaid = context.watch<Cart>().totalPrice + 10.0;
    return FutureBuilder<DocumentSnapshot>(
        future: customer.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Material(
              color: Colors.grey.shade200,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey.shade200,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.grey.shade200,
                    leading: const AppbarBackButton(),
                    title: const TitleAppbar(title: 'Payment'),
                    centerTitle: true,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${totalPaid.toStringAsFixed(2)} USD',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total order',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${totalPrice.toStringAsFixed(2)} USD',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Shipping Coast',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '10.00 USD',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                RadioListTile(
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                    // print(selectedValue);
                                  },
                                  title: const Text('Cash On Delivery'),
                                  subtitle: const Text('Pay Cash At Home'),
                                ),
                                RadioListTile(
                                  value: 2,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                    // print(selectedValue);
                                  },
                                  title:
                                      const Text('Pay via visa /Master Card'),
                                  subtitle: Row(children: const [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.blue,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Icon(
                                        FontAwesomeIcons.ccMastercard,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.ccVisa,
                                      color: Colors.blue,
                                    ),
                                  ]),
                                ),
                                RadioListTile(
                                  value: 3,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                    // print(selectedValue);
                                  },
                                  title: const Text('Pay viva Paypal'),
                                  subtitle: Row(
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.paypal,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.ccPaypal,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomSheet: Container(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: YellowButton(
                        name: 'Confirm ${totalPaid.toStringAsFixed(2)} USD',
                        width: 1,
                        onPressed: () {
                          if (selectedValue == 1) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 100,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Pay At Home ${totalPaid.toStringAsFixed(2)} \$',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      YellowButton(
                                        name:
                                            'Confirm ${totalPaid.toStringAsFixed(2)} \$',
                                        width: 0.9,
                                        onPressed: () async {
                                          showProgress();
                                          for (var item in context
                                              .read<Cart>()
                                              .getItems) {
                                            CollectionReference orderRef =
                                                FirebaseFirestore.instance
                                                    .collection('orders');
                                            orderId = const Uuid().v4();
                                            await orderRef.doc(orderId).set({
                                              'cid': data['cid'],
                                              'custname': data['name'],
                                              'email': data['email'],
                                              'address': data['address'],
                                              'phone': data['phone'],
                                              'prrofileimage':
                                                  data['profileimage'],
                                              'sid': item.suppId,
                                              'proid': item.documentId,
                                              'orderid': orderId,
                                              'ordername': item.name,
                                              'orderimage':
                                                  item.imagesUrl.first,
                                              'orderqty': item.qty,
                                              'orderprice':
                                                  item.qty * item.price,
                                              'deliverystatus': 'preparing',
                                              'deliverydate': '',
                                              'orderdate': DateTime.now(),
                                              'paymentstatus':
                                                  'cash on delivery',
                                              'orderreview': false,
                                            }).whenComplete(() async {
                                              await FirebaseFirestore.instance
                                                  .runTransaction(
                                                      (transaction) async {
                                                DocumentReference
                                                    documentReference =
                                                    FirebaseFirestore.instance
                                                        .collection('products')
                                                        .doc(item.documentId);
                                                DocumentSnapshot snapshot1 =
                                                    await transaction
                                                        .get(documentReference);
                                                transaction.update(
                                                  documentReference,
                                                  {
                                                    'instock':
                                                        snapshot1['instock'] -
                                                            item.qty,
                                                  },
                                                );
                                              });
                                            });
                                          }
                                          context.read<Cart>().clearCart();
                                          Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  '/user_screen'));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (selectedValue == 2) {
                            print('Visa');
                          } else if (selectedValue == 3) {
                            print('Paypal');
                          }
                          // print(selectedValue);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
