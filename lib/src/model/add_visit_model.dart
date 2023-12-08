import 'package:flutter/material.dart';

class AddVisitModel {
  bool isloading = false;
  bool isSuccess = false;
  String idStatus = ''; //checkin / checkout
  String lat = '';
  String long = '';
  int originSelectId = 0;
  String originSelectName = '';
  final location = TextEditingController();
  final keterangan = TextEditingController();
  final statusVisit = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  List<Category> category = [];

  List<Category> getSuggestionsCategory(String query) =>
      List.of(category).where((em) {
        final userLower = em.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}

class Category {
  String id;
  String name;

  Category({required this.id, required this.name});
}
