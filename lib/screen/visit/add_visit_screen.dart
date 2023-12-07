import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:novistock/helper/constants.dart';
import 'package:novistock/src/model/add_visit_model.dart';

import '../../src/presenter/add_visit_presenter.dart';
import '../../src/state/add_visit_state.dart';

class AddVisitScreen extends StatefulWidget {
  const AddVisitScreen({super.key});

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen>
    implements AddVisitState {
  late AddVisitModel _addVisitModel;
  late AddVisitPresenter _addVisitPresenter;

  // Daftar pilihan untuk dropdown, berisi Map dengan pasangan ID dan nama
  final List<Map<String, dynamic>> _dropdownItems = [
    {'id': '0', 'name': 'checkin'},
    {'id': '1', 'name': 'checkout'},
  ];

  _AddVisitScreenState() {
    _addVisitPresenter = AddVisitPresenter();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  @override
  void initState() {
    _addVisitPresenter.view = this;
    super.initState();
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
                color: kLightBlue,
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
                            'Visit checkin',
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
                              child: Text('CheckIn atau Checkout ?',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 25,
                        margin: const EdgeInsets.only(
                            top: 1, left: 28, bottom: 1, right: 28),
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xff2D8EFF)),
                            )),
                        child: TypeAheadFormField(
                          hideSuggestionsOnKeyboardHide: false,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _addVisitModel.statusVisit,
                            decoration: const InputDecoration(
                                hintText: "CheckIn atau checkOut",
                                border: InputBorder.none,
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 9),
                                fillColor: Color(0xff9397a0),
                                hintStyle: TextStyle(
                                    color: Color(0xff2D8EFF), fontSize: 14)),
                          ),
                          suggestionsCallback: (pattern) {
                            // Gantilah ini dengan daftar pilihan statis Anda
                            return _dropdownItems
                                .where((item) => item['name']
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder:
                              (context, Map<String, dynamic> suggestion) {
                            return ListTile(
                              title: Text(suggestion['name']),
                            );
                          },
                          noItemsFoundBuilder: (context) => const SizedBox(
                            height: 110,
                            child: Center(
                              child: Text(
                                'Not Found.',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          onSuggestionSelected:
                              (Map<String, dynamic> suggestion) {
                            setState(() {
                              _addVisitModel.idStatus = suggestion['id'];
                              _addVisitModel.statusVisit.text =
                                  suggestion['name'];
                            });
                          },
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
                          controller: _addVisitModel.keterangan,
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
                              Icons.location_on_outlined,
                              color: kBlue,
                              size: 22,
                            )),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kLightWhite,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Location',
                                  style: kPoppinsSemiBold.copyWith(
                                      color: kDarkBlue, fontSize: 14))),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Text(
                            '${_addVisitModel.lat}, ${_addVisitModel.long}',
                            style: kPoppinsRegularBold.copyWith(
                                color: kDarkBlue, fontSize: 12)),
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: BoxDecoration(
                      //           color: kWhite,
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: const InkWell(
                      //           child: Icon(
                      //         Icons.camera_alt_outlined,
                      //         color: kBlue,
                      //         size: 22,
                      //       )),
                      //     ),
                      //     Container(
                      //         padding: const EdgeInsets.all(8),
                      //         decoration: BoxDecoration(
                      //             color: kLightWhite,
                      //             borderRadius: BorderRadius.circular(8)),
                      //         child: Text('Picture',
                      //             style: kPoppinsSemiBold.copyWith(
                      //                 color: kDarkBlue, fontSize: 14))),
                      //   ],
                      // ),

                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 203, 204, 235),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _getCurrentLocation().then((value) {
                                setState(() {
                                  _addVisitModel.lat = '${value.latitude}';
                                  _addVisitModel.long = '${value.longitude}';
                                  _addVisitModel.location.text =
                                      '${value.latitude}, ${value.longitude}';
                                });
                                // _liveLocation();
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 203, 204, 235)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const InkWell(
                                    child: Icon(
                                  Icons.location_on,
                                  color: kBlue,
                                  size: 28,
                                )),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Get Location',
                                    style: kPoppinsMediumBold.copyWith(
                                        color: kDarkBlue, fontSize: 14))
                              ],
                            ),
                          )),
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
            //         _openMap(_addVisitModel.lat, _addVisitModel.long);
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
                    if (_addVisitModel.lat == '') {
                      Fluttertoast.showToast(
                          msg: 'pastikan sudah scan lokasi 👋',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15);
                    } else {
                      _addVisitPresenter.visit();
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
  void refreshData(AddVisitModel addVisitModel) {
    _addVisitModel = addVisitModel;
  }
}
