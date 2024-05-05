import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novistock/helper/constants.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  var db = FirebaseFirestore.instance;
  String today = '';

  @override
  void initState() {
    today = getFormattedDate();
    super.initState();
  }

  String getFormattedDate() {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('stocks')
            .where('expired_date', isLessThanOrEqualTo: today)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshots.hasError) {
            return const Center(child: Text('Error'));
          }

          final dataProducts = snapshots.data!.docs;

          if (dataProducts.isEmpty) {
            return const Center(
              child: Text('No expired stocks found'),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: dataProducts.length,
            itemBuilder: (context, index) {
              final productData = dataProducts[index].data();
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
                      Text('Stock Expired $today',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: kPoppinsSemiBold.copyWith(
                              fontSize: 14, color: kRed)),
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
            },
          );
        },
      ),
    );
  }
}
