// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/add_stock_model.dart';
import '../state/add_stock_state.dart';

abstract class AddStockPresenterAbstract {
  set view(AddStockState view) {}
  void visit() {}
}

class AddStockPresenter implements AddStockPresenterAbstract {
  var db = FirebaseFirestore.instance;
  final AddStockModel _addStockModel = AddStockModel();
  late AddStockState _addStockState;
  DateTime now = DateTime.now();

  @override
  void visit() async {
    _addStockModel.isloading = true;
    _addStockState.refreshData(_addStockModel);
    String createddate = DateFormat("yyyy-MMMM-dd").format(DateTime.now());
    String createdtime = DateFormat("HH:mm:ss").format(DateTime.now());

    final visit = <String, dynamic>{
      "expired_date": _addStockModel.expiredDate.text,
      "product_name": _addStockModel.productName.text,
      "site_name": _addStockModel.originSelectName.text,
      "qty": _addStockModel.qty.text,
      "description": _addStockModel.keterangan.text,
      "createdDate": createddate,
      "createdTime": createdtime,
    };
    print(visit);
    db.collection("stocks").add(visit).then((value) {
      _addStockState.onSuccess('data disimpan');
      _addStockModel.isloading = false;
      _addStockState.refreshData(_addStockModel);
    }).onError((error, stackTrace) {
      _addStockState.onError(error.toString());
      _addStockModel.isloading = false;
      _addStockState.refreshData(_addStockModel);
    });
  }

  @override
  set view(AddStockState view) {
    _addStockState = view;
    _addStockState.refreshData(_addStockModel);
  }
}
