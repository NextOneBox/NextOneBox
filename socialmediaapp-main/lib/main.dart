import 'package:flutter/material.dart';
// ignore: deprecated_member_use

import 'screens/nav_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TopG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavScreen(),
    );
  }
}
