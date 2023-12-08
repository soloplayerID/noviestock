import 'package:flutter/material.dart';

class AddStockModel {
  bool isloading = false;
  bool isSuccess = false;
  late TextEditingController originSelectName = TextEditingController();
  late TextEditingController expiredDate = TextEditingController();
  late TextEditingController productName = TextEditingController();
  late TextEditingController keterangan = TextEditingController();
  late TextEditingController qty = TextEditingController();
}
