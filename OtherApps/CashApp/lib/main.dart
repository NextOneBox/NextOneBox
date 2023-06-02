import 'otherfiles/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:14d236d49602da6ffd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Complete tasks',
        channelDescription: "Complete tasks and get paid",
        defaultColor: Color(0XFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true)
  ]);

  Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  Directory docume = await getApplicationDocumentsDirectory();

  Hive.init(docume.path);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));

  await Hive.openBox('user');
  await Hive.openBox('pkacc');
  await Hive.openBox('notif');
  await Hive.openBox('leads');
  await Hive.openBox('tasks');
  await Hive.openBox('refer');
  await Hive.openBox('leadsteps');
  await Hive.openBox('widrawstaus');
  await Hive.openBox('globalmessage');
  await Hive.openBox('LeaderBoard');
  await Hive.openBox('MyAnalytic');
  await Hive.openBox('profitlink');
  await Hive.openBox('adsbox');
  await Hive.openBox('localballance');
  await Hive.openBox('quiz');
  await Hive.openBox('contacts');

  LocalNotificationService.initialize();
  SendAllData();

  runApp(MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: BackColor,
        secondaryHeaderColor: BackColor,
        iconTheme: IconThemeData(color: MainColor),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavigation()));
}
