import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../helper/constants.dart';
import 'stock/add_stock_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  var db = FirebaseFirestore.instance;
  Map<String, dynamic>? destinationResponse;

  // void searchFromFirebase() async {
  //   final result =
  //       (await FirebaseFirestore.instance.collection('stocks').get()).docs;

  //   setState(() {
  //     stockResponse = result.map((e) => e.data()).toList();
  //     print('===idproduct: ${stockResponse[0]['id_product']}');
  //   });
  // }

  // void getFromFirebase() async {
  //   final DocumentSnapshot result = await FirebaseFirestore.instance
  //       .collection('products')
  //       .doc("0Xa6sRt7cxrdkLdsANUU")
  //       .get();

  //   setState(() {
  //     destinationResponse =
  //         result.data() as Map<String, dynamic>?; // Konversi eksplisit
  //     if (destinationResponse != null) {
  //       print('Product Name: ${destinationResponse!['product_name']}');
  //     }
  //   });
  // }

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
              height: 95,
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
                              builder: (context) => const AddStockScreen()));
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Novie',
                      style: kPoppinsRegularBold.copyWith(
                          color: kGrey, fontSize: 16),
                    ),
                    Text(
                      'Stocks',
                      style: kPoppinsMediumBold.copyWith(
                          color: kAlmostLightBlue, fontSize: 28),
                    ),
                    const SizedBox(height: 12),
                    StreamBuilder(
                      stream: db.collection('stocks').snapshots(),
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
                        // Olah data
                        var dataProducts = snapshots.data!.docs;
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: dataProducts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => DetailScreen(
                                  //       harga: dataDestinations[index].data()['harga'],
                                  //       imgUrl: dataDestinations[index].data()['image'],
                                  //       placeName: dataDestinations[index].data()['name'],
                                  //       desc: dataDestinations[index].data()['desc'],
                                  //       destination: dataDestinations[index].data()['destination'],
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  height: 160,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0XFFf5f6f8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
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
                                                color: const Color(0xFF4c4c4c),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Expired Date: ${dataProducts[index].data()['expired_date']}',
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 13,
                                                    color:
                                                        const Color(0xFF4c4c4c),
                                                  ),
                                                ),
                                                Text(
                                                  'nama Site: ${dataProducts[index].data()['site_name']}',
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 13,
                                                    color:
                                                        const Color(0xFF4c4c4c),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 14),
                                            Text(
                                              'qty: ${dataProducts[index].data()['qty']}',
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFE91E5A),
                                              ),
                                            ),
                                            const SizedBox(height: 14),
                                            Text(
                                              'desc: ${dataProducts[index].data()['description']}',
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF4c4c4c),
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
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
