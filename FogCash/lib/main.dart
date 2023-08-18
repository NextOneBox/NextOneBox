import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
  Directory docume = await getApplicationDocumentsDirectory();

  Hive.init(docume.path);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));

  await Hive.openBox('user');
  await Hive.openBox('tasks');
  await Hive.openBox('widrawstaus');
  await Hive.openBox('LeaderBoard');
  await Hive.openBox('videos');
  await Hive.openBox('adsbox');
  await Hive.openBox('localballance');
  await Hive.openBox('contacts');

  SendAllData();
  HowEarnPoster();
  runApp(
    MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          secondaryHeaderColor: SecondaryColor,
          iconTheme: const IconThemeData(color: SecondaryColor),
          fontFamily: 'Proxima Nova',
        ),
        debugShowCheckedModeBanner: false,
        home: BottomNavigation()),
  );
}
