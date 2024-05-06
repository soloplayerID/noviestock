// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
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
    checkExpiredStock(today);
  }

  String getFormattedDate() {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedDate;
  }

  void checkExpiredStock(String today) async {
    final stockRef = FirebaseFirestore.instance.collection('stocks');
    final querySnapshot =
        await stockRef.where('expired_date', isLessThanOrEqualTo: today).get();
    String username = 'ilhamtaufik22@gmail.com'; //Your Email
    String password =
        'gvobpglpkmqdfuuc'; // 16 Digits App Password Generated From Google Account

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    if (querySnapshot.docs.isNotEmpty) {
      final message = Message()
            ..from = Address(username, 'alert stock')
            ..recipients.add('ilhamtaufikp@gmail.com')
            // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // For Adding Multiple Recipients
            // ..bccRecipients.add(Address('a@gmail.com')) For Binding Carbon Copy of Sent Email
            ..subject = 'Mail from Mailer'
            ..text =
                'Berikut adalah daftar stock yang sudah expired:\n\n ${querySnapshot.docs.map((doc) => '${doc['product_name']} - ${doc['qty']}: ${doc['expired_date']}').join('\n')}'
          // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"; // For Adding Html in email
          // ..attachments = [
          //   FileAttachment(File('image.png'))  //For Adding Attachments
          //     ..location = Location.inline
          //     ..cid = '<myimg@3.141>'
          // ]
          ;

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: $sendReport');
      } on MailerException catch (e) {
        print('Message not sent.');
        print(e.message);
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    } else {
      print('No expired stocks found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: StreamBuilder(
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

          var dataProducts = snapshots.data!.docs;

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Stock Expired $today qty: ${dataProducts[index].data()['qty']}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: kPoppinsSemiBold.copyWith(
                              fontSize: 14, color: kRed)),
                      Text(
                          'Barang ${dataProducts[index].data()['product_name']}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: kPoppinsRegularBold.copyWith(
                            fontSize: 12,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('ambil tindakan',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: kPoppinsRegularBold.copyWith(
                              fontSize: 12, color: Colors.blueAccent)),
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
