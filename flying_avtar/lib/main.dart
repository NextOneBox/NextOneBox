import 'package:flutter/material.dart';
import 'package:flying_avtar/fly.dart';

void main() {
  runApp(CrashGameApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
