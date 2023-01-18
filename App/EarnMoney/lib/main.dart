import 'otherfiles/widgets.dart';
import 'package:cron/cron.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  AwesomeNotifications().initialize(null, // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Proto Coders Point',
            channelDescription: "Notification example",
            defaultColor: Color(0XFF9050DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            enableVibration: true)
      ]);
  final cron = Cron();
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key1',
            title: 'Title for your notification',
            body: 'body text/ content'));
  });
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:9d932b74e857195ffd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));

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

  LocalNotificationService.initialize();
  SendAnalytics();
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      MonthYearPickerLocalizations.delegate,
    ],
    theme: ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      iconTheme: IconThemeData(color: MainColor),
      fontFamily: 'Proxima Nova',
    ),
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset(
        'assets/flash.png',
      ),
      duration: 1000,
      screenFunction: () async {
        if (user.isNotEmpty) {
          return DoubleBack(child: BottomNavigation());
        } else {
          return LoginScr();
        }
      },
    ),
  ));
}
