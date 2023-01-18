import 'package:game/home.dart';

import 'widgets.dart';

void main() async {
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Colors.black),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen.withScreenFunction(
        splash: Image.asset(
          'assets/flash.png',
        ),
        duration: 1000,
        screenFunction: () async {
          return HomePage();
        },
      )));
}