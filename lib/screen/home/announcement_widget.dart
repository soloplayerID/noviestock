import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:novistock/helper/constants.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.only(right: 20),
              width: 208,
              height: 100,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: kDarkBlue.withOpacity(0.051),
                      offset: const Offset(0.0, 3.0),
                      blurRadius: 24.0,
                      spreadRadius: 0.0,
                    ),
                  ]),
              child: Column(
                children: [
                  Text('Stock Expired',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          kPoppinsSemiBold.copyWith(fontSize: 14, color: kRed)),
                  Text('Barang mendekati masa expired',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: kPoppinsRegularBold.copyWith(
                        fontSize: 12,
                      )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
