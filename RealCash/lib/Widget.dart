import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'HomePage.dart';

var totalbalance = account?.get(0)['ballance'];
Color c3 = Colors.black;
Color c1 = Color.fromARGB(255, 9, 73, 237);
Color dc = Color.fromARGB(255, 125, 157, 238);
Color c6 = Colors.white;
Box? limits = Hive.box('limits');
Box? VIP = Hive.box('VIP');
var textstyle = TextStyle(color: c3, fontWeight: FontWeight.w500);


Widget sh(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sw(double width) {
  return SizedBox(
    width: width,
  );
}