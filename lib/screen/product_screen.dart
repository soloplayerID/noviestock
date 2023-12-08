import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../helper/constants.dart';
import 'product/add_product_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var db = FirebaseFirestore.instance;

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
              padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Icon(LineIcons.arrowLeft,
                        color: Colors.white, size: 30),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddProductScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kLightWhite,
                          borderRadius: BorderRadius.circular(12)),
                      child: const InkWell(
                          child: Icon(
                        Icons.add,
                        color: Colors.black,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: const Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text('Hello Novie',
                        style: kPoppinsRegularBold.copyWith(
                            color: kGrey, fontSize: 16)),
                    Text('products',
                        style: kPoppinsMediumBold.copyWith(
                            color: kAlmostLightBlue, fontSize: 28)),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                          stream: db.collection('products').snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshots.hasError) {
                              return const Center(child: Text('Error'));
                            }
                            //Olah data
                            var dataProducts = snapshots.data!.docs;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: dataProducts.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => DetailScreen(
                                    //               harga: dataDestinations[index]
                                    //                   .data()['harga'],
                                    //               imgUrl:
                                    //                   dataDestinations[index]
                                    //                       .data()['image'],
                                    //               placeName:
                                    //                   dataDestinations[index]
                                    //                       .data()['name'],
                                    //               desc: dataDestinations[index]
                                    //                   .data()['desc'],
                                    //               destination: dataDestinations[
                                    //                       index]
                                    //                   .data()['destination'],
                                    //             )));
                                  },
                                  child: Container(
                                    height: 120,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: const Color(0XFFf5f6f8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      children: [
                                        //animation or picture
                                        dataProducts[index].data()['image'] ==
                                                null
                                            ? SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.asset(
                                                  "assets/dummy.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  "${dataProducts[index].data()['image']}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // how do you feel + get started button
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dataProducts[index]
                                                    .data()['product_name'],
                                                style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xFF4c4c4c),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                '${dataProducts[index].data()['product_code']} 🌟',
                                                style: GoogleFonts.nunito(
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0xFF4c4c4c),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
