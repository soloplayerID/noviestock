import 'package:flutter/material.dart';

import '../screen/account_screen.dart';
import '../screen/stock_screen.dart';
import '../screen/visit_screen.dart';
import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../screen/product_screen.dart';

final routes = {
  '/': (BuildContext context) => const LoginScreen(),
  '/home': (BuildContext context) => const HomeScreen(),
  '/visit': (BuildContext context) => const VisitScreen(),
  '/product': (BuildContext context) => const ProductScreen(),
  '/stock': (BuildContext context) => const StockScreen(),
  '/account': (BuildContext context) => const AccountScreen(),
};
