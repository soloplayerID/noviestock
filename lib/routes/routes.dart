import 'package:flutter/material.dart';
import 'package:novistock/screen/visite_screen.dart';

import '../screen/home_screen.dart';
import '../screen/login_screen.dart';


final routes = {
  '/': (BuildContext context) => const LoginScreen(),
  '/home': (BuildContext context) => const HomeScreen(),
  '/visite': (BuildContext context) => const VisiteScreen(),
};