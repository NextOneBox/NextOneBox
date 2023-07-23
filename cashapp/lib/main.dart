
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:14d236d49602da6ffd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));
  // await Firebase.initializeApp();
  Directory docume = await getApplicationDocumentsDirectory();

  Hive.init(docume.path);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));

  await Hive.openBox('user');
  await Hive.openBox('tasks');
  await Hive.openBox('widrawstaus');
  await Hive.openBox('LeaderBoard');
  await Hive.openBox('adsbox');
  await Hive.openBox('localballance');
  await Hive.openBox('contacts');
  
  SendAllData();
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
        home:  BottomNavigation()),
  );
}
