// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helper/constants.dart';

class ModalSearchCalender extends StatefulWidget {
  final bool isCalender;
  const ModalSearchCalender({super.key, required this.isCalender});

  @override
  State<ModalSearchCalender> createState() => _ModalSearchCalenderState();
}

class _ModalSearchCalenderState extends State<ModalSearchCalender> {
  // List searchResult = [];
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  // void searchFromFirebase(String query) async {
  //   final result = (await FirebaseFirestore.instance
  //           .collection('province')
  //           .where('name', whereIn: [query]).get())
  //       .docs;

  //   setState(() {
  //     searchResult = result.map((e) => e.data()).toList();
  //     print('=== $searchResult');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // implement the search field

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: kWhite, borderRadius: BorderRadius.circular(8)),
                    child: const InkWell(
                        child: Icon(
                      Icons.timelapse,
                      color: kBlue,
                      size: 22,
                    )),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: kLightWhite,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text('masukan Expired product',
                          style: kPoppinsSemiBold.copyWith(
                              color: kDarkBlue, fontSize: 14))),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: kLighterWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TableCalendar(
                  calendarStyle: const CalendarStyle(
                      canMarkersOverflow: true,
                      holidayTextStyle: TextStyle(color: Colors.orange),
                      todayTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                  calendarFormat: CalendarFormat.month,
                  firstDay: DateTime.utc(2022, 12, 1),
                  lastDay: DateTime.utc(2050, 3, 14),
                  focusedDay: today,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, focusedDay)) {
                      setState(() {
                        today = focusedDay;
                        Navigator.pop(context, today.toString().split(" ")[0]);
                        // _addDailyReportModel.tanggalDaily.text = today.toString().split(" ")[0];
                        // _addLemburModel.tanggallembur.text = today.toString().split(" ")[0];
                      });
                    }
                  },
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  shouldFillViewport: true,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
