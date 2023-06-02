import 'dart:collection';

import 'package:game/home.dart';
import 'package:game/web.dart';

import 'widgets.dart';

void main() async {
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Colors.black),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home:HomePage()
      )
      );
}