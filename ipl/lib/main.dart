import 'dart:convert';
import 'dart:io';
import 'package:ipl/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:ipl/payment.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Firebase.initializeApp();
  Directory docume = await getApplicationDocumentsDirectory();

  Hive.init(docume.path);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));

  await Hive.openBox('user');
  await Hive.openBox('team');

  runApp(MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        secondaryHeaderColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: Myapp()));
}

class Myapp extends StatefulWidget {
  Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

Box user = Hive.box('user');

class _MyappState extends State<Myapp> {
  DateTime now = DateTime.now();
  getteam() async {
    http.Response response =
        await http.get(Uri.parse('https://realcash.nextonebox.com/w/ShowTeam'));

    if (response.reasonPhrase == 'OK') {
      await team.clear();
      var da = jsonDecode(response.body);
      for (var a in da) {
        await team.add(a);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getteam();
    if (user.isEmpty) {
      return LoginScr();
    } else {
      dynamic plan = user.get(0)['plan'];
      // return Home();

      if (2023321 >= int.parse(plan)) {
        return PaymentPage();
      } else {
        return Home();
      }
    }
  }
}
