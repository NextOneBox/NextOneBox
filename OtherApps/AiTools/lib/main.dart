import 'package:MyChatAi/OtherFiles/premium.dart';
import 'package:MyChatAi/OtherFiles/widgets.dart';
import 'package:MyChatAi/App/home.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  getkey();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:a2c487c9fd5735e4fd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));

  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  Directory docume = await getApplicationDocumentsDirectory();
  Hive.init(docume.path);

  await Hive.openBox('account');
  await Hive.openBox('history');
  await Hive.openBox('adtime');
  await Hive.openBox('contacts');
  await Hive.openBox('MyAnalytic');
  await Hive.openBox('apikey');
  await Hive.openBox('coins');
  await Hive.openBox('adsbox');


  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: MainColor),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavigation()));
}

