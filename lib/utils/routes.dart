import 'package:flutter/material.dart';
import 'package:test_login/screens/login_screen.dart';
import 'package:test_login/screens/home_screen.dart';
import 'package:test_login/screens/detailsPoi_screen.dart';
import 'package:test_login/screens/startMenu_screen.dart';
import 'package:test_login/screens/kpi_screen.dart';
import 'package:test_login/screens/poiProxi_screen.dart';

final routes = {
  '/': (BuildContext context) => new MyForm(),
  '/login': (BuildContext context) => new MyForm(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/detailsPoi': (BuildContext context) => new DetailsPoiScreen(),
  '/startMenu': (BuildContext context) => new StartMenu(),
  '/kpi': (BuildContext context) => new KpiMenu(),
  '/poiProxi': (BuildContext context) => new PoiProxi(),
};