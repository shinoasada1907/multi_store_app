import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/screens/minor_screen/edit_store.dart';
import 'package:multi_store/widgets/appbar_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/product_model.dart';

class VisitStoreScreen extends StatefulWidget {
  final String sId;
  const VisitStoreScreen({super.key, required this.sId});

  @override
  State<VisitStoreScreen> createState() => _VisitStoreScreenState();
}

class _VisitStoreScreenState extends State<VisitStoreScreen> {
  bool following = false;
  @override
  Widget build(BuildContext context) {
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('suppliers');
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.sId)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.sId).get(),
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
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade100,
            appBar: AppBar(
              leading: const LightBlueBackButton(),
              toolbarHeight: 120,
              flexibleSpace: data['coverimage'] == ''
                  ? Image.asset(
                      'assets/images/inapp/coverimage.jpg',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      data['coverimage'],
                      fit: BoxFit.cover,
                    ),
              title: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4.0,
                        color: Colors.lightBlue,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.network(
                        data['profileimage'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data['name'].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            border: Border.all(
                              width: 3.0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: data['sid'] ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditStore(
                                          data: data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Icon(
                                        Icons.edit,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      following = !following;
                                    });
                                  },
                                  child: following == true
                                      ? const Text(
                                          'Following',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )
                                      : const Text(
                                          'Follow',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: productStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'Store is not product',
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.green,
              child: const Icon(
                FontAwesomeIcons.whatsapp,
                size: 40,
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.lightBlue,
          ),
        );
      },
    );
  }
}
