// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ModalSearchProduct extends StatefulWidget {
  final List productResponse;
  final bool isCalender;
  const ModalSearchProduct(
      {super.key, required this.productResponse, required this.isCalender});

  @override
  State<ModalSearchProduct> createState() => _ModalSearchProductState();
}

class _ModalSearchProductState extends State<ModalSearchProduct> {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        suffixIcon: const Icon(Icons.close),
                        hintText: 'Tulis Nama product',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // This button is used to close the search modal
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'))
                ],
              ),

              // display other things like search history, suggestions, search results, etc.
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.productResponse.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        onTap: () {
                          print(widget.productResponse[index]['product_name']);
                          Navigator.pop(context, index);
                        },
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            widget.productResponse[index]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title:
                            Text(widget.productResponse[index]['product_name']),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
