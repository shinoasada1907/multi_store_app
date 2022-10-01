import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/screens/main_screens/visit_store.dart';
import 'package:multi_store/widgets/appbar_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const TitleAppbar(
          title: 'Stores',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('suppliers').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 25,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VisitStoreScreen(
                            sId: snapshot.data!.docs[index]['sid'],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child:
                                  Image.asset('assets/images/inapp/store.jpg'),
                            ),
                            Positioned(
                              bottom: 28,
                              left: 10,
                              child: SizedBox(
                                height: 48,
                                width: 100,
                                child: Image.network(
                                  snapshot.data!.docs[index]['profileimage'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data!.docs[index]['name'].toLowerCase(),
                          style: const TextStyle(
                            fontFamily: 'Acme',
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text('No Stores'),
            );
          },
        ),
      ),
    );
  }
}
