import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Session extends GetxController {
  final getStorage = GetStorage();
  String id() => getStorage.read("id");
  String name() => getStorage.read("name");
  String email() => getStorage.read("email");
  String gender() => getStorage.read("gender");
  String birthday() => getStorage.read("birthday");
  String age() => getStorage.read("age");
  String phone() => getStorage.read("phone");
  int silverPrice() => 1;
  int goldPrice() => 2;
  int platinumPrice() => 3;
}
