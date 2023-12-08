import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:novistock/helper/constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // text fiedl controller
  final TextEditingController _prductNameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  PlatformFile? pickedFile;
  var db = FirebaseFirestore.instance;
  String imageUrl = '';

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'images/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

    imageUrl = await ref.getDownloadURL();
    String createddate = DateFormat("yyyy-MMMM-dd").format(DateTime.now());
    String createdtime = DateFormat("HH:mm:ss").format(DateTime.now());

    final product = <String, dynamic>{
      "product_name": _prductNameController.text,
      "product_code": _productCodeController.text,
      "image": imageUrl,
      "createdDate": createddate,
      "createdTime": createdtime,
    };

    db.collection("products").add(product).then((value) {
      Navigator.pushReplacementNamed(context, "/home");
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                color: kAlmostLightBlue,
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                height: 190,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Icon(LineIcons.arrowLeft,
                              color: Colors.white, size: 30),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Products',
                            style: kPoppinsMediumBold.copyWith(
                                color: kLighterWhite, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: kBlue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: kBlue,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const InkWell(
                                        child: Icon(
                                      Icons.timer_outlined,
                                      color: kLighterWhite,
                                      size: 16,
                                    )),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: const Color(0xfffafafa),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (pickedFile != null)
                        Container(
                          height: 150,
                          width: 150,
                          color: Colors.blue[100],
                          child: Center(
                              child: Image.file(
                            File(pickedFile!.path!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8)),
                            child: const InkWell(
                                child: Icon(
                              Icons.notification_important,
                              color: kBlue,
                              size: 22,
                            )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('nama product',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(
                            top: 1, left: 28, bottom: 1, right: 28),
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TextFormField(
                          controller: _prductNameController,
                          validator: (value) {
                            return value!.length < 5
                                ? 'Tulis minimal 5 karakter'
                                : null;
                          },
                          onChanged: (str) {},
                          style: const TextStyle(color: kGrey, fontSize: 14),
                          decoration: const InputDecoration(
                              hintText: "Tulis nama",
                              border: InputBorder.none,
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 9),
                              fillColor: kGrey,
                              hintStyle: TextStyle(
                                  color: Color(0xff2D8EFF), fontSize: 12)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8)),
                            child: const InkWell(
                                child: Icon(
                              Icons.notification_important,
                              color: kBlue,
                              size: 22,
                            )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('code product',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(
                            top: 1, left: 28, bottom: 1, right: 28),
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TextFormField(
                          controller: _productCodeController,
                          validator: (value) {
                            return value!.length < 3
                                ? 'Tulis minimal 3 karakter'
                                : null;
                          },
                          onChanged: (str) {},
                          style: const TextStyle(color: kGrey, fontSize: 14),
                          decoration: const InputDecoration(
                              hintText: "Tulis code product",
                              border: InputBorder.none,
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 9),
                              fillColor: kGrey,
                              hintStyle: TextStyle(
                                  color: Color(0xff2D8EFF), fontSize: 12)),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (pickedFile == null)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(50),
                          child: ElevatedButton(
                              onPressed: () {
                                selectFile();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kLightGreen),
                              ),
                              child: Text('pilih foto',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kWhite, fontSize: 14))),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                  onPressed: () {
                    uploadFile();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kLightBlue),
                  ),
                  child: Text('simpan',
                      style: kPoppinsSemiBold.copyWith(
                          color: kWhite, fontSize: 14))),
            )
          ],
        ),
      ),
    );
  }
}
