import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../helper/constants.dart';
import 'visit/add_visit_screen.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen({super.key});

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
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
                              builder: (context) => const AddVisitScreen()));
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
                    Text('Kunjungan',
                        style: kPoppinsMediumBold.copyWith(
                            color: kAlmostLightBlue, fontSize: 28)),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                          stream: db.collection('visits').snapshots(),
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
                            var dataVisits = snapshots.data!.docs;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: dataVisits.length,
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
                                        color: kLighterGreen,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${dataVisits[index].data()['createdDate']}',
                                                maxLines: 2,
                                                style:
                                                    kPoppinsMediumBold.copyWith(
                                                        color: kLightBlue,
                                                        fontSize: 13.3)),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffFFF0C5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                    '${dataVisits[index].data()['visitName']}',
                                                    style: kPoppinsMediumBold
                                                        .copyWith(
                                                            color: kDarkBlue,
                                                            fontSize: 14)))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                        '${dataVisits[index].data()['description']}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style:
                                                            kPoppinsMediumBold
                                                                .copyWith(
                                                                    color:
                                                                        kGrey,
                                                                    fontSize:
                                                                        14))),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                      '${dataVisits[index].data()['createdTime']}',
                                                      style: kPoppinsMediumBold
                                                          .copyWith(
                                                              color: kDarkBlue,
                                                              fontSize: 14)),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: kLightWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.arrow_right,
                                                    color: kGrey,
                                                  )),
                                            ),
                                          ],
                                        )
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
