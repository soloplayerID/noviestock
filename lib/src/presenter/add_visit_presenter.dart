// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/add_visit_model.dart';
import '../state/add_visit_state.dart';

abstract class AddVisitPresenterAbstract {
  set view(AddVisitState view) {}
  void visit() {}
}

class AddVisitPresenter implements AddVisitPresenterAbstract {
  var db = FirebaseFirestore.instance;
  final AddVisitModel _addVisitModel = AddVisitModel();
  late AddVisitState _addVisitState;
  DateTime now = DateTime.now();

  @override
  void visit() async {
    _addVisitModel.isloading = true;
    _addVisitState.refreshData(_addVisitModel);
    String createddate = DateFormat("yyyy-MMMM-dd").format(DateTime.now());
    String createdtime = DateFormat("HH:mm:ss").format(DateTime.now());

    final visit = <String, dynamic>{
      "description": _addVisitModel.keterangan.text,
      "location": "${_addVisitModel.lat}, ${_addVisitModel.long}",
      "visitName": _addVisitModel.statusVisit.text,
      "createdDate": createddate,
      "createdTime": createdtime,
    };
    print(visit);
    db.collection("visits").add(visit).then((value) {
      _addVisitState.onSuccess('data disimpan');
      _addVisitModel.isloading = false;
      _addVisitState.refreshData(_addVisitModel);
    }).onError((error, stackTrace) {
      _addVisitState.onError(error.toString());
      _addVisitModel.isloading = false;
      _addVisitState.refreshData(_addVisitModel);
    });
  }

  @override
  set view(AddVisitState view) {
    _addVisitState = view;
    _addVisitState.refreshData(_addVisitModel);
  }
}
