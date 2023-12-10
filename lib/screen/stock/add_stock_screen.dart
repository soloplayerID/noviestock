// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:novistock/helper/constants.dart';
import 'package:novistock/src/presenter/add_stock_presenter.dart';
import 'package:novistock/src/state/add_stock_state.dart';

import '../../src/model/add_stock_model.dart';
import '../fragments/icon_text_widget.dart';
import '../fragments/modal_search.dart';
import '../fragments/modal_search_expired.dart';
import '../fragments/modal_search_products.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStocknState();
}

class _AddStocknState extends State<AddStockScreen> implements AddStockState {
  late AddStockModel _addStockModel;
  late AddStockPresenter _addStockPresenter;
  List siteResponse = [];
  List productsResponse = [];

  _AddStocknState() {
    _addStockPresenter = AddStockPresenter();
  }

  // Future<Position> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  // }

  @override
  void initState() {
    _addStockPresenter.view = this;
    super.initState();
    getSiteFromFirebase();
  }

  void getSiteFromFirebase() async {
    final result =
        (await FirebaseFirestore.instance.collection('sites').get()).docs;
    final resultProduct =
        (await FirebaseFirestore.instance.collection('products').get()).docs;

    setState(() {
      siteResponse = result.map((e) => e.data()).toList();
      productsResponse = resultProduct.map((e) => e.data()).toList();
      print('=== $siteResponse');
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
                            'Add Stock',
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8)),
                            child: const InkWell(
                                child: Icon(
                              Icons.flight_takeoff_rounded,
                              color: kBlue,
                              size: 22,
                            )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Site Kunjungan',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModalSearch(
                                    destinationResponse: siteResponse,
                                    isCalender: false,
                                  ),
                                )).then((value) {
                              print(
                                  '=== hasil adalah ${siteResponse[value]['site_name']}');
                              setState(() {
                                _addStockModel.originSelectName.text =
                                    siteResponse[value]['site_name'];
                              });
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            child: AppIconText(
                              icon: Icons.flight_takeoff_rounded,
                              text: "Site",
                              destination:
                                  _addStockModel.originSelectName.text == ''
                                      ? 'tekan disini'
                                      : _addStockModel.originSelectName.text,
                            ),
                          )),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8)),
                            child: const InkWell(
                                child: Icon(
                              Icons.production_quantity_limits,
                              color: kBlue,
                              size: 22,
                            )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Product Name',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModalSearchProduct(
                                    productResponse: productsResponse,
                                    isCalender: false,
                                  ),
                                )).then((value) {
                              print(
                                  '=== hasil adalah ${productsResponse[value]['product_name']}');
                              setState(() {
                                _addStockModel.productName.text =
                                    productsResponse[value]['product_name'];
                              });
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            child: AppIconText(
                              icon: Icons.production_quantity_limits,
                              text: "Product Name",
                              destination: _addStockModel.productName.text == ''
                                  ? 'tekan disini'
                                  : _addStockModel.productName.text,
                            ),
                          )),
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
                              Icons.date_range,
                              color: kBlue,
                              size: 22,
                            )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Expired Date',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ModalSearchCalender(
                                    isCalender: false,
                                  ),
                                )).then((value) {
                              print('=== hasil adalah value');
                              setState(() {
                                _addStockModel.expiredDate.text = value;
                              });
                            });
                          },
                          child: SizedBox(
                            height: 100,
                            child: AppIconText(
                              icon: Icons.date_range,
                              text: "Expired",
                              destination: _addStockModel.expiredDate.text == ''
                                  ? 'tekan disini'
                                  : _addStockModel.expiredDate.text,
                            ),
                          )),
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
                              child: Text('Keterangan',
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
                          controller: _addStockModel.keterangan,
                          validator: (value) {
                            return value!.length < 5
                                ? 'Tulis minimal 5 karakter'
                                : null;
                          },
                          onChanged: (str) {},
                          style: const TextStyle(color: kGrey, fontSize: 14),
                          decoration: const InputDecoration(
                              hintText: "Tulis keterangan *jika perlu",
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
                              child: Text('qty',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 1, left: 28, bottom: 1, right: 28),
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TextFormField(
                          controller: _addStockModel.qty,
                          validator: (value) {
                            return value!.length < 5
                                ? 'Tulis minimal 5 karakter'
                                : null;
                          },
                          onChanged: (str) {},
                          style: const TextStyle(color: kGrey, fontSize: 14),
                          decoration: const InputDecoration(
                              hintText: "Tulis QTY",
                              border: InputBorder.none,
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 9),
                              fillColor: kGrey,
                              hintStyle: TextStyle(
                                  color: Color(0xff2D8EFF), fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: const EdgeInsets.all(20),
            //   child: ElevatedButton(
            //       onPressed: () {
            //         _openMap(_addStockModel.lat, _addStockModel.long);
            //       },
            //       style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(kLightBlue),
            //       ),
            //       child: Text('cek maps',
            //           style: kPoppinsSemiBold.copyWith(
            //               color: kWhite, fontSize: 14))),
            // ),
            // const SizedBox(
            //   height: 12,
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                  onPressed: () {
                    if (_addStockModel.qty.text == '' ||
                        _addStockModel.originSelectName.text == '') {
                      Fluttertoast.showToast(
                          msg: 'pastikan site dan qty 👋',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15);
                    } else {
                      _addStockPresenter.visit();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kLightBlue),
                  ),
                  child: Text('Kunjungan',
                      style: kPoppinsSemiBold.copyWith(
                          color: kWhite, fontSize: 14))),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 15);
  }

  @override
  void onSuccess(String success) {
    Fluttertoast.showToast(
        msg: success,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 15);
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void refreshData(AddStockModel addStockModel) {
    _addStockModel = addStockModel;
  }
}
