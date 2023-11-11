import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../helper/constants.dart';

class VisiteScreen extends StatefulWidget {
  const VisiteScreen({super.key});

  @override
  State<VisiteScreen> createState() => _VisiteScreenState();
}

class _VisiteScreenState extends State<VisiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              color: kLightBlue,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ListView.builder(
                            itemCount: 1,
                            scrollDirection: Axis.vertical,
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Container(
                              height: 120,
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: kLighterGreen,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('2023-07-11',
                                          maxLines: 2,
                                          style: kPoppinsMediumBold.copyWith(
                                              color: kLightBlue,
                                              fontSize: 13.3)),
                                      Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFFF0C5),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text('Checkin',
                                              style:
                                                  kPoppinsMediumBold.copyWith(
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
                                                  'prociez 123',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: kPoppinsMediumBold
                                                      .copyWith(
                                                          color: kGrey,
                                                          fontSize: 14))),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                                'visit kesini',
                                                style:
                                                    kPoppinsMediumBold.copyWith(
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
                                            onTap: () {
                                              
                                            },
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
                          )
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