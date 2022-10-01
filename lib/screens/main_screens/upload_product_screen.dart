// ignore_for_file: avoid_print, duplicate_ignore, sort_child_properties_last, depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store/models/utilities/categ_list.dart';
import 'package:multi_store/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;

  String mainCateValue = 'select category';
  String subCateValue = 'subcategory';
  List<String> subCateList = [];

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String> imageUrlList = [];
  dynamic _pickedImageError;

  bool processing = false;

  void _pickProductImage() async {
    try {
      final pickedImage = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imageFileList = pickedImage!;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future<void> uploadImage() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (imageFileList!.isNotEmpty) {
        //thực hiện tạo vòng lập để add hình ảnh lên storage trên firebase
        setState(() {
          processing = true;
        });
        try {
          for (var images in imageFileList!) {
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref('products/${path.basename(images.path)}');

            await ref.putFile(File(images.path)).whenComplete(() async {
              await ref.getDownloadURL().then((value) {
                imageUrlList.add(value);
              });
            });
          }
        } catch (e) {
          print(e);
        }
      } else {
        MessageHandler.showSnackSar(_scaffoldKey, 'Please pick images');
      }
    } else {
      MessageHandler.showSnackSar(_scaffoldKey, 'Please fill all field');
    }
  }

  void uploadData() async {
    if (imageUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');

      proId = const Uuid().v4();

      await productRef.doc(proId).set({
        'productid': proId,
        'maincateg': mainCateValue,
        'subcateg': subCateValue,
        'price': price,
        'instock': quantity,
        'proname': proName,
        'prodesc': proDesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imageUrlList,
        'discount': 0
      }).whenComplete(() {
        setState(() {
          processing = false;
          imageFileList = [];
          mainCateValue = 'select category';
          subCateList = [];
          imageUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      print('No Image');
    }
  }

  void uploadProduct() async {
    await uploadImage().whenComplete(() => uploadData());
  }

  void selectcatagory(String? value) {
    if (value == 'select category') {
      subCateList = [];
    } else if (value == 'men') {
      subCateList = men;
    } else if (value == 'women') {
      subCateList = women;
    } else if (value == 'electronics') {
      subCateList = electronics;
    } else if (value == 'shoes') {
      subCateList = shoes;
    } else if (value == 'home & garden') {
      subCateList = homeandgarden;
    } else if (value == 'beauty') {
      subCateList = beauty;
    } else if (value == 'kids') {
      subCateList = kids;
    } else if (value == 'bags') {
      subCateList = bags;
    }
    setState(() {
      mainCateValue = value!;
      subCateValue = 'subcategory';
    });
  }

  Widget previewImage() {
    if (imageFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: imageFileList!.length,
        itemBuilder: (context, index) {
          return Image.file(File(imageFileList![index].path));
        },
      );
    } else {
      return const Center(
        child: Text(
          'you have not \n \n picked image yet!',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.blueGrey.shade100,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: imageFileList != null
                              ? previewImage()
                              : const Center(
                                  child: Text(
                                    'you have not \n \n picked image yet!',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '* select main category',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    DropdownButton(
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: Colors.lightBlue.shade400,
                                      value: mainCateValue,
                                      items: maincateg
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        selectcatagory(value);
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '* select subcategory',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    DropdownButton(
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      iconDisabledColor: Colors.black,
                                      dropdownColor: Colors.lightBlue.shade400,
                                      disabledHint:
                                          const Text('select category'),
                                      value: subCateValue,
                                      items: subCateList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          subCateValue = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.lightBlue,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter price';
                          } else if (value.isValidPrice() != true) {
                            return 'not valid price';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          price = double.parse(newValue!);
                        },
                        decoration: textFormDecoration1.copyWith(
                          labelText: 'Price',
                          hintText: 'Price .. \$',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter quantity';
                          } else if (value.isValidQuantity() != true) {
                            return 'not valid Quantity';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          quantity = int.parse(newValue!);
                        },
                        decoration: textFormDecoration1.copyWith(
                          labelText: 'Quantity',
                          hintText: 'Add Quantity',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        proName = newValue!;
                      },
                      maxLength: 100,
                      maxLines: 3,
                      decoration: textFormDecoration1.copyWith(
                        labelText: 'Product name',
                        hintText: 'Enter product name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product description';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        proDesc = newValue!;
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: textFormDecoration1.copyWith(
                        labelText: 'Product desciption',
                        hintText: 'Enter product description',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: imageFileList!.isEmpty
                    ? () {
                        _pickProductImage();
                      }
                    : () {
                        setState(() {
                          imageFileList = [];
                        });
                      },
                child: Icon(
                  imageFileList!.isEmpty
                      ? Icons.photo_library
                      : Icons.delete_forever,
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              child: processing == true
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
            )
          ],
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

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
