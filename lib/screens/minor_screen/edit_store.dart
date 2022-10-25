// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store/widgets/appbar_widget.dart';
import 'package:multi_store/widgets/snackbar.dart';
import 'package:multi_store/widgets/yellowbutton_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({super.key, required this.data});

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

  final ImagePicker _picker = ImagePicker();
  XFile? imageFileLogo;
  XFile? imageFileCover;
  dynamic _pickedImageError;
  late String storeName;
  late String phone;
  late String storeLogo;
  late String storeCover;
  bool proccessing = false;

  pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickedStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });

      print(_pickedImageError);
    }
  }

  pickCoverBackgroundImage() async {
    try {
      final pickedCoverBackgroundImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileCover = pickedCoverBackgroundImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });

      print(_pickedImageError);
    }
  }

  Future uploadStoreLogo() async {
    if (imageFileLogo != null) {
      try {
        //Upload profile tài khoản
        //Tạo thư mục quản lý ảnh trên storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('supp-images/${widget.data['email']}.jpg');
        //Put ảnh lên folder vừa tạo
        await ref.putFile(File(imageFileLogo!.path));
        //Download đường dẫn sau khi put ảnh lên folder
        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeLogo = widget.data['profileimage'];
    }
  }

  Future uploadCoverBackgoundImage() async {
    if (imageFileCover != null) {
      try {
        //Upload profile tài khoản
        //Tạo thư mục quản lý ảnh trên storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('background-supp-images/${widget.data['email']}.jpg');
        //Put ảnh lên folder vừa tạo
        await ref.putFile(File(imageFileCover!.path));
        //Download đường dẫn sau khi put ảnh lên folder
        storeCover = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeCover = widget.data['coverimage'];
    }
  }

  editStoreData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('suppliers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'name': storeName,
        'phone': phone,
        'profileimage': storeLogo,
        'coverimage': storeCover,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        proccessing = true;
      });
      await uploadStoreLogo().whenComplete(() async =>
          await uploadCoverBackgoundImage()
              .whenComplete(() => editStoreData()));
    } else {
      MessageHandler.showSnackSar(scaffoldkey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldkey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const TitleAppbar(title: 'Edit Store'),
          leading: const AppbarBackButton(),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      'Store logo',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['profileimage']),
                        ),
                        Column(
                          children: [
                            YellowButton(
                              name: 'Change',
                              width: 0.25,
                              onPressed: () {
                                pickStoreLogo();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            imageFileLogo == null
                                ? const SizedBox()
                                : YellowButton(
                                    name: 'Reset',
                                    width: 0.25,
                                    onPressed: () {
                                      setState(() {
                                        imageFileLogo = null;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        imageFileLogo == null
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  File(imageFileLogo!.path),
                                ),
                              ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Divider(
                        color: Colors.lightBlue,
                        thickness: 2.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Cover Backgound Image',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['coverimage']),
                        ),
                        Column(
                          children: [
                            YellowButton(
                              name: 'Change',
                              width: 0.25,
                              onPressed: () {
                                pickCoverBackgroundImage();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            imageFileCover == null
                                ? const SizedBox()
                                : YellowButton(
                                    name: 'Reset',
                                    width: 0.25,
                                    onPressed: () {
                                      setState(() {
                                        imageFileCover = null;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        imageFileCover == null
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  File(imageFileCover!.path),
                                ),
                              ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Divider(
                        color: Colors.lightBlue,
                        thickness: 2.5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your store name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      storeName = value!;
                    },
                    initialValue: widget.data['name'],
                    decoration: textFormDecoration1.copyWith(
                      labelText: 'Store name',
                      hintText: 'Enter store name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phone = value!;
                    },
                    initialValue: widget.data['phone'],
                    decoration: textFormDecoration1.copyWith(
                      labelText: 'Phone',
                      hintText: 'Enter phone number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YellowButton(
                        name: 'Cancle',
                        width: 0.25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      proccessing == true
                          ? YellowButton(
                              name: 'Please wait ..',
                              width: 0.5,
                              onPressed: () {
                                Null;
                              },
                            )
                          : YellowButton(
                              name: 'Save Changes',
                              width: 0.5,
                              onPressed: () {
                                saveChanges();
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecoration1 = InputDecoration(
  labelText: 'Price',
  hintText: 'Price .. \$',
  labelStyle: const TextStyle(color: Colors.blueAccent),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  ),
);
