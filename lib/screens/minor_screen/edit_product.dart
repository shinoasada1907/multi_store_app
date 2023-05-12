import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store/models/utilities/categ_list.dart';
import 'package:multi_store/widgets/delete_button_widget.dart';
import 'package:multi_store/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:multi_store/widgets/yellowbutton_widget.dart';
import 'package:path/path.dart' as path;

class EditProductScreen extends StatefulWidget {
  final dynamic items;
  const EditProductScreen({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;
  int? discount = 0;

  String mainCateValue = 'select category';
  String subCateValue = 'subcategory';
  List<String> subCateList = [];

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String> imageUrlList = [];

  dynamic pickedImageError;

  bool processing = false;

  void _pickProductImage() async {
    try {
      final pickedImage = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imageFileList = pickedImage;
      });
    } catch (e) {
      setState(() {
        pickedImageError = e;
      });
      // print(pickedImageError);
    }
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

  Future<void> uploadImage() async {
    List<dynamic> listproduct = widget.items['proimages'];
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (imageFileList!.isNotEmpty) {
        if (mainCateValue == 'select category' &&
            subCateValue == 'subcategory') {
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
            mainCateValue = widget.items['maincateg'];
            subCateValue = widget.items['subcateg'];
          } catch (e) {
            // print(e);
          }
        } else {
          MessageHandler.showSnackSar(_scaffoldKey, 'Please select categories');
        }
      } else {
        imageUrlList = listproduct.map((e) => e.toString()).toList();
      }
    } else {
      MessageHandler.showSnackSar(_scaffoldKey, 'Please fill all field');
    }
  }

  editProductData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('products')
          .doc(widget.items['productid']);
      transaction.update(documentReference, {
        'maincateg': mainCateValue,
        'subcateg': subCateValue,
        'price': price,
        'instock': quantity,
        'proname': proName,
        'prodesc': proDesc,
        'proimages': imageUrlList,
        'discount': discount,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async {
    await uploadImage().whenComplete(() => editProductData());
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

  Widget previewCurrentImage() {
    List<dynamic> itemImage = widget.items['proimages'];
    return ListView.builder(
      itemCount: itemImage.length,
      itemBuilder: (context, index) {
        return Image.network(itemImage[index].toString());
      },
    );
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              color: Colors.blueGrey.shade100,
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: previewCurrentImage(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          ' main category',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          margin: const EdgeInsets.all(6),
                                          constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              widget.items['maincateg'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          ' subcategory',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          margin: const EdgeInsets.all(6),
                                          constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              widget.items['subcateg'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ExpandablePanel(
                          theme: const ExpandableThemeData(hasIcon: false),
                          header: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightBlue,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Center(
                                child: Text(
                                  'Chang Image & Categories',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          collapsed: const SizedBox(),
                          expanded: changeImage(),
                        )
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                            initialValue:
                                widget.items['price'].toStringAsFixed(2),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter price';
                              } else if (value.isValidPrice() != true) {
                                return 'invalid price';
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
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                            maxLength: 2,
                            initialValue: widget.items['discount'].toString(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else if (value.isValidDiscount() != true) {
                                return 'invalid discount';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              discount = int.parse(newValue!);
                            },
                            decoration: textFormDecoration1.copyWith(
                              labelText: 'Discount',
                              hintText: 'Discount .. %',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        initialValue: widget.items['instock'].toString(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter quantity';
                          } else if (value.isValidQuantity() != true) {
                            return 'invalid Quantity';
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
                      initialValue: widget.items['proname'],
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
                      initialValue: widget.items['prodesc'],
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                        YellowButton(
                          name: 'Ok',
                          width: 0.5,
                          onPressed: () {
                            saveChanges();
                          },
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DeleteButton(
                        name: 'Delete',
                        width: 0.7,
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(widget.items['productid']);
                            transaction.delete(documentReference);
                          }).whenComplete(() => Navigator.pop(context));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget changeImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
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
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
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
                            disabledHint: const Text('select category'),
                            value: subCateValue,
                            items: subCateList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: imageFileList!.isNotEmpty
                ? YellowButton(
                    name: 'Reset Images',
                    width: 0.6,
                    onPressed: () {
                      setState(() {
                        imageFileList = [];
                      });
                    },
                  )
                : YellowButton(
                    name: 'Change images',
                    width: 0.6,
                    onPressed: () {
                      _pickProductImage();
                    },
                  ),
          ),
        ],
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

extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}
